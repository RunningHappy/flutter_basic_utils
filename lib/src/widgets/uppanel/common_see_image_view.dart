import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

///
/// 预览图片
///
class CommonImageView extends StatefulWidget {
  final int currentIndex;
  final List<String> imageList;
  final double minScale;
  final double maxScale;
  final Function(int) downLoad;

  const CommonImageView(
      {Key? key,
        this.currentIndex = 0,
        required this.imageList,
        this.minScale = 0.5,
        this.maxScale = 3,
        required this.downLoad})
      : super(key: key);

  @override
  _CommonImageViewState createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> {
  var currentIndex = 1;

  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: widget.currentIndex,
    );
    _pageController.addListener(() {});
    setState(() {
      currentIndex = widget.currentIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
          title: Text(
            currentIndex.toString() + '/' + widget.imageList.length.toString(),
            style: TextStyle(fontSize: 22.sp, color: Colors.white),
          ),
          actions: [
            Icon(
              Icons.close,
              color: Colors.transparent,
              size: 24.sp,
            ),
          ],
        ),
        body: Stack(
          children: [
            PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return widget.imageList[index].contains('http') ||
                      widget.imageList[index].contains('https')
                      ? PhotoViewGalleryPageOptions(
                      heroAttributes: PhotoViewHeroAttributes(tag: index),
                      imageProvider: NetworkImage(
                        widget.imageList[index],
                      ))
                      : PhotoViewGalleryPageOptions(
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                    imageProvider: AssetImage(
                      widget.imageList[index],
                    ),
                  );
                },
                itemCount: widget.imageList.length,
                backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
                pageController:
                PageController(initialPage: widget.currentIndex),
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index + 1;
                  });
                }),
            Positioned(
                right: 20.w,
                bottom: 20.w + MediaQuery.of(context).padding.bottom,
                child: GestureDetector(
                  onTap: () {
                    widget.downLoad(currentIndex - 1);
                  },
                  child: Icon(
                    Icons.download_sharp,
                    color: Colors.white,
                    size: 26.sp,
                  ),
                ))
          ],
        ));
  }
}

class CommonSeeImageView {
  const CommonSeeImageView._();

  /// 预览一组图片
  static Future<T?> preview<T>(
      BuildContext context, {
        int initialIndex = 0,
        required List<String> images,
        required Function(int) downLoad,
      }) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CommonImageView(
              imageList: images,
              currentIndex: initialIndex,
              downLoad: downLoad,
            )));
  }
}
