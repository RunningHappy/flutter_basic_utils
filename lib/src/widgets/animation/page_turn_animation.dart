import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// 翻页动画
// 首先，动画分两部分，内容主体的滑动（这里定义为图片的滑动，方便解释）和底部滑动栏。
// 图片的滑动可以使用一个 Stack 将两个图片垂直堆叠起来，然后在滑动时改变上面那一层图片的显示大小。在滑动时，图片上的内容有一些轻轻的浮动，这个可以通过 Transform 稍微改变一下位置实现。
// 底部的滑动栏的动画比较复杂，要考虑四个因素，第一是大小的改变，第二是中间图标的透明效果，第三是左侧显示实心圆，右侧显示空心圆，第四是始终保持大圆在中间，这样当有十多张图时效果依然好。
// 手势配合动画实现滑动，将主组件和滑动组件分开了，所以必须有一个通信的桥梁，这里使用了 StreamController ，这个类在主组件中使用 streamController.stream.listen 来实现监听，在滑动组件中，不停地往这个类中注入数据，进而让主组件刷新状态。
class PageTurnAnimation extends StatefulWidget {
  const PageTurnAnimation({Key? key}) : super(key: key);

  @override
  _PageTurnAnimationState createState() => _PageTurnAnimationState();
}

class _PageTurnAnimationState extends State<PageTurnAnimation>
    with TickerProviderStateMixin {
  late StreamController<SlideUpdate> streamController;
  late AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  int nextIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _PageTurnAnimationState() {
    streamController = StreamController();
    streamController.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging ||
            event.updateType == UpdateType.animation) {
          slideDirection = event.slideDirection!;
          slidePercent = event.slidePercent;
          if (slideDirection == SlideDirection.leftToRight) {
            nextIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextIndex = activeIndex + 1;
          } else {
            nextIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          TransitionGoal transitionGoal;
          if (slidePercent > 0.5) {
            transitionGoal = TransitionGoal.open;
          } else {
            transitionGoal = TransitionGoal.close;
          }
          animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: transitionGoal,
              slidePercent: slidePercent,
              slideUpdateStream: streamController,
              vsync: this);
          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.doneAnimation) {
          activeIndex = nextIndex;
          slidePercent = 0.0;
          slideDirection = SlideDirection.none;
          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Page(
              pageViewModel: pages[activeIndex],
              percentVisible: 1.0,
            ),
            PageReveal(
                revealPercent: slidePercent,
                child: Page(
                  pageViewModel: pages[nextIndex],
                  percentVisible: slidePercent,
                )),
            PageIndicator(
                pageIndicatorViewModel: PageIndicatorViewModel(
                    pages, activeIndex, slideDirection, slidePercent)),
            PageDragger(
              canDragToLeft: activeIndex < pages.length - 1,
              canDragToRight: activeIndex > 0,
              streamController: streamController,
            )
          ],
        ),
      ),
    );
  }
}

/// ====================

class PageDragger extends StatefulWidget {
  const PageDragger(
      {Key? key,
      required this.streamController,
      required this.canDragToRight,
      required this.canDragToLeft})
      : super(key: key);
  final StreamController<SlideUpdate> streamController;
  final bool canDragToRight;
  final bool canDragToLeft;

  @override
  State<StatefulWidget> createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const fullTransitionPx = 300.0;

  late Offset dragStart;
  late SlideDirection slideDirection;
  double slidePercent = 0.0;

  onHorizontalDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onHorizontalDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx < 0.0 && widget.canDragToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else if (dx > 0.0 && widget.canDragToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / fullTransitionPx).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.streamController
          .add(SlideUpdate(UpdateType.dragging, slideDirection, slidePercent));
    }
  }

  onHorizontalDragEnd(DragEndDetails details) {
    widget.streamController
        .add(SlideUpdate(UpdateType.doneDragging, SlideDirection.none, 0.0));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
    );
  }
}

class AnimatedPageDragger {
  static const percentPerMillisecond = 0.005;
  final SlideDirection? slideDirection;
  final TransitionGoal? transitionGoal;

  late AnimationController completeAnimationController;

  AnimatedPageDragger(
      {this.slideDirection,
      this.transitionGoal,
      slidePercent,
      required StreamController<SlideUpdate> slideUpdateStream,
      required TickerProvider vsync}) {
    var startSlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;
    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / percentPerMillisecond).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / percentPerMillisecond).round());
    }

    completeAnimationController = AnimationController(
        vsync: vsync, duration: duration)
      ..addListener(() {
        slidePercent = ui.lerpDouble(startSlidePercent, endSlidePercent,
            completeAnimationController.value);

        slideUpdateStream.add(SlideUpdate(
            UpdateType.doneAnimation, slideDirection, slidePercent));
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          SlideUpdate(UpdateType.doneDragging, slideDirection, endSlidePercent);
        }
      });
  }

  run() {
    completeAnimationController.forward(from: 0.0);
  }

  dispose() {
    completeAnimationController.dispose();
  }
}

enum TransitionGoal { open, close }

enum UpdateType { dragging, doneDragging, animation, doneAnimation }

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection? slideDirection;
  final double slidePercent;

  SlideUpdate(this.updateType, this.slideDirection, this.slidePercent);
}

/// =====================

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, required this.pageIndicatorViewModel})
      : super(key: key);
  final PageIndicatorViewModel pageIndicatorViewModel;

  @override
  Widget build(BuildContext context) {
    List<PagerBubble> bubbles = [];
    for (int i = 0; i < pageIndicatorViewModel.pages.length; i++) {
      final page = pageIndicatorViewModel.pages[i];

      double percentActive;
      if (i == pageIndicatorViewModel.activeIndex) {
        percentActive = 1.0 - pageIndicatorViewModel.slidePercent;
      } else if (i == pageIndicatorViewModel.activeIndex - 1 &&
          pageIndicatorViewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = pageIndicatorViewModel.slidePercent;
      } else if (i == pageIndicatorViewModel.activeIndex + 1 &&
          pageIndicatorViewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = pageIndicatorViewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > pageIndicatorViewModel.activeIndex ||
          (i == pageIndicatorViewModel.activeIndex &&
              pageIndicatorViewModel.slideDirection ==
                  SlideDirection.leftToRight);

      bubbles.add(PagerBubble(
          pagerBubbleViewModel: PagerBubbleViewModel(
              page.iconAssetIcon, page.color, isHollow, percentActive)));
    }

    const bubbleWidth = 55.0;
    final baseTransition =
        ((pageIndicatorViewModel.pages.length * bubbleWidth) / 2) -
            (bubbleWidth / 2);
    var transition =
        baseTransition - (pageIndicatorViewModel.activeIndex * bubbleWidth);
    if (pageIndicatorViewModel.slideDirection == SlideDirection.leftToRight) {
      transition += pageIndicatorViewModel.slidePercent * bubbleWidth;
    } else if (pageIndicatorViewModel.slideDirection ==
        SlideDirection.rightToLeft) {
      transition -= pageIndicatorViewModel.slidePercent * bubbleWidth;
    }

    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Transform(
          transform: Matrix4.translationValues(transition, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

enum SlideDirection { leftToRight, rightToLeft, none }

class PageIndicatorViewModel {
  List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PageIndicatorViewModel(
      this.pages, this.activeIndex, this.slideDirection, this.slidePercent);
}

class PagerBubble extends StatelessWidget {
  const PagerBubble({Key? key, required this.pagerBubbleViewModel})
      : super(key: key);
  final PagerBubbleViewModel pagerBubbleViewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.0,
      height: 65.0,
      child: Center(
        child: Container(
          width: ui.lerpDouble(20.0, 45.0, pagerBubbleViewModel.activePercent),
          height: ui.lerpDouble(20.0, 45.0, pagerBubbleViewModel.activePercent),
          decoration: BoxDecoration(
              color: pagerBubbleViewModel.isHollow
                  ? const Color(0x88FFFFFF).withAlpha(
                      (0x88 * pagerBubbleViewModel.activePercent).round())
                  : const Color(0x88FFFFFF),
              border: Border.all(
                  color: pagerBubbleViewModel.isHollow
                      ? const Color(0x88FFFFFF).withAlpha(
                          (0x88 * (1.0 - pagerBubbleViewModel.activePercent))
                              .round())
                      : Colors.transparent,
                  width: 3.0),
              shape: BoxShape.circle),
          child: Opacity(
            opacity: pagerBubbleViewModel.activePercent,
            child: Image.asset(
              pagerBubbleViewModel.iconAssetsPath,
              color: pagerBubbleViewModel.color,
            ),
          ),
        ),
      ),
    );
  }
}

class PagerBubbleViewModel {
  final String iconAssetsPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PagerBubbleViewModel(
      this.iconAssetsPath, this.color, this.isHollow, this.activePercent);
}

/// ============

class PageReveal extends StatelessWidget {
  const PageReveal({Key? key, required this.revealPercent, required this.child})
      : super(key: key);
  final double revealPercent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  CircleRevealClipper(this.revealPercent);

  final double revealPercent;

  @override
  Rect getClip(Size size) {
    final epicenter = Offset(size.width / 2, size.height * 0.9);

    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;
    return Rect.fromLTWH(
        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

/// ===================

final pages = [
  PageViewModel(
      const Color(0xFF678FB4),
      'assets/hotels.png',
      'Hotels',
      'All hotels and hostels are sorted by hospitality rating',
      'assets/key.png'),
  PageViewModel(
      const Color(0xFF65B0B4),
      'assets/banks.png',
      'Banks',
      'We carefully verify all banks before adding them into the app',
      'assets/wallet.png'),
  PageViewModel(
    const Color(0xFF9B90BC),
    'assets/stores.png',
    'Store',
    'All local stores are categorized for your convenience',
    'assets/shopping_cart.png',
  ),
];

class Page extends StatelessWidget {
  const Page({Key? key, required this.pageViewModel, this.percentVisible = 1.0})
      : super(key: key);
  final PageViewModel pageViewModel;
  final double percentVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: pageViewModel.color,
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  pageViewModel.heroAssetPath,
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Text(
                  pageViewModel.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "FlamanteRoma",
                      fontSize: 34.0),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Text(
                pageViewModel.body,
                style: const TextStyle(
                    color: Colors.white, fontFamily: "FlamanteRoma"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetIcon;

  PageViewModel(this.color, this.heroAssetPath, this.title, this.body,
      this.iconAssetIcon);
}
