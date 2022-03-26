import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBanner extends Container{
  final List<String> imageList;
  final int? autoDuration;
  final Function(int)? tapImageBack;
  final List<Widget> children;
  final AlignmentGeometry? paginationAlign;
  final double? paginationPaddingH;
  final double? paginationPaddingV;
  final Widget normalPagination;
  final Widget activePagination;
  final Axis? swiperAxis;
  final MainAxisAlignment? mainAlign;
  CommonBanner({Key? key,
    required this.imageList,
    this.autoDuration,
    this.tapImageBack,
    required this.children,
    this.paginationAlign,
    this.paginationPaddingH,
    this.paginationPaddingV,
    required this.normalPagination,
    required this.activePagination,
    this.swiperAxis,
    this.mainAlign
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Swiper(
      viewportFraction: 1,
      autoplayDelay: autoDuration??3000,
      scrollDirection: swiperAxis??Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
      itemCount: imageList.length,
      onTap: (index) async {
        if(tapImageBack != null){
          tapImageBack!(index);
        }
      },
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        builder: SwiperCustomPagination(
          builder: (context, SwiperPluginConfig config) {
            return imageList.length > 1 ? Align(
              alignment: paginationAlign??Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: paginationPaddingH??24.w, bottom: paginationPaddingV??21.h),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: List.generate(imageList.length, (index) {
                    return config.activeIndex == index ? activePagination : normalPagination;
                  }),
                ),
              ),
            ): Container();
          }
        )
      ),
      autoplay: imageList.length <= 1 ? false : true,
      loop: imageList.length <= 1 ? false : true,
    );
  }
}