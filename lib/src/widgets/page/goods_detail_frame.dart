import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 商品详情框架（布局导航栏放TabBar（商品、评价、详情），
/// 点击tab，内容页ScrollView滚动到指定位置）
class GoodsDetailFrame extends StatefulWidget {
  const GoodsDetailFrame({Key? key}) : super(key: key);

  @override
  _GoodsDetailFrameState createState() => _GoodsDetailFrameState();
}

class _GoodsDetailFrameState extends State<GoodsDetailFrame>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;
  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _evaluateKey = GlobalKey();
  final GlobalKey _detailKey = GlobalKey();
  double _oneY = 0.0;
  double _twoY = 0.0;
  double _threeY = 0.0;
  final List _tabs = ["商品", "评价", "详情"];

  @override
  void dispose() {
    _tabController!.dispose();
    _scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        var of = _scrollController!.offset;
        if (of > _threeY - _oneY) {
          _tabController!.animateTo(2);
        } else if (of > _twoY - _oneY) {
          _tabController!.animateTo(1);
        } else {
          _tabController!.animateTo(0);
        }
      });
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  void _subInitState() {
    _oneY = _getY(_headerKey.currentContext);
    _twoY = _getY(_evaluateKey.currentContext);
    _threeY = _getY(_detailKey.currentContext);
  }

  double _getY(BuildContext? buildContext) {
    if (buildContext == null) return 0.0;
    final RenderBox renderBox = buildContext.findRenderObject() as RenderBox;
    final topLeftPosition = renderBox.localToGlobal(Offset.zero);
    return topLeftPosition.dy;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _subInitState());
    var titleBox = SizedBox(
      // width: 250.w,
      child: TabBar(
          controller: _tabController,
          labelColor: Colors.red,
          indicatorColor: Colors.red,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.green,
          labelStyle: TextStyle(fontSize: 36.sp),
          unselectedLabelStyle: TextStyle(fontSize: 36.sp),
          tabs: _tabs.map((e) => Text(e)).toList(),
          onTap: (int index) {
            switch (index) {
              case 0:
                _scrollController!.jumpTo(0);
                _tabController!.animateTo(0);
                break;
              case 1:
                _scrollController!.jumpTo(_twoY - _oneY);
                _tabController!.animateTo(1);
                break;
              case 2:
                _scrollController!.jumpTo(_threeY - _oneY);
                _tabController!.animateTo(2);
                break;
            }
          }),
    );
    var webViewBox = Container(
      color: Colors.white,
      child: Html(
        // 渲染的数据
        data: '<html><p><span><img alt="" src="https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.huabanimg.com%2F790a691e3e20d378fafc1e6bf7351d350ee90fc63aa6ae-7ACydT_fw658&refer=http%3A%2F%2Fhbimg.huabanimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645067218&t=ea9e2efc369e2cb85d8334868bd30c57" style="max-width:100%border:0" /></span></span></p></html>',
        // 自定义样式
        style: {},
        customRender: {
          "flutter": (RenderContext context, Widget widget) {
            return FlutterLogo(
              style: (context.tree.attributes['horizontal'] != null) ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
              textColor: context.style.color as Color,
              size: context.style.fontSize!.size! * 5,
            );
          }
        },
        onImageError: (Object exception, StackTrace? stackTrace) {
          debugPrint(exception.toString());
        }
      ),
    );
    var bodyBox = Column(
      children: [
        Flexible(
          child: ListView(
            shrinkWrap: true,
            controller: _scrollController,
            children: [
              Column(
                children: [
                  Container(key: _headerKey, color: Colors.red, height: 600.h),
                  Container(
                      key: _evaluateKey, color: Colors.green, height: 800.h),
                  Container(key: _detailKey, child: webViewBox)
                ],
              )
            ],
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: titleBox,
      ),
      body: bodyBox,
    );
  }
}
