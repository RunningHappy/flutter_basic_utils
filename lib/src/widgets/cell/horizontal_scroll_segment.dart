import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 横向滚动 tab
class PurchaseQuotationSegment extends StatefulWidget
    implements PreferredSizeWidget {
  final BuildContext? context;
  final List dataList;
  const PurchaseQuotationSegment({Key? key, required this.context, required this.dataList})
      : super(key: key);

  @override
  _PurchaseQuotationSegmentState createState() =>
      _PurchaseQuotationSegmentState();

  @override
  Size get preferredSize {
    return Size(MediaQuery.of(context!).size.width, 80.h);
  }
}

class _PurchaseQuotationSegmentState extends State<PurchaseQuotationSegment> {
  // {'gtTypeName': '全部', 'select': true, 'gtId': 0}
  List _dataList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      getListContent();
    });
    initEvent();
  }

  initEvent() {
    bus.on('updateTypes', (arg) {
      if (mounted) {
        getListContent();
      }
    });
    bus.on('refreshTypes', (arg) {
      if (mounted) {
        for (var item in _dataList) {
          if (item['gtTypeName'] == '全部') {
            item['select'] = true;
          } else {
            item['select'] = false;
          }
        }
        setState(() {});
        // bus.emit('changeBiddingType',{'gtId':0});
        // bus.emit('changeInviteType',{'gtId':0});
      }
    });
  }

  getListContent() async {
    setState(() {
      _dataList = widget.dataList;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bus.off('updateTypes');
    bus.off('refreshTypes');
  }

  // 获取某个widget 的坐标 我们这里可以得到
  double _renderObjectX(GlobalKey globalKey) {
    RenderObject? evaluationRenderObject = globalKey.currentContext!.findRenderObject();
    return  evaluationRenderObject!.getTransformTo(null).getTranslation().x;
  }

  // 获取 widget 在屏幕上的坐标点，然后比较屏幕中心点的x值，然后进行 +/-
  double _renderObjectOriginX(GlobalKey globalKey) {
    RenderBox renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero).dx;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        color: Colors.white,
        // 随着向上滑动，TabBar的宽度逐渐增大
        // 父布局Container约束为 center对齐
        // 所以程现出来的是中间x轴放大的效果
        width: MediaQuery.of(context).size.width,
        height: 78.h,
        child: Row(
          children: [
            Expanded(
                child: Container(
                  height: 78.h,
                  margin: EdgeInsets.only(left: 21.w),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _dataList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        GlobalKey _globalKey = GlobalKey();
                        return GestureDetector(
                          key: _globalKey,
                          onTap: () {
                            // if (dataList.length >= 4) {
                            //   if (index >= 4 || index <= dataList.length - 4) {
                            //     double itemWidthX = _renderObjectX(_globalKey);
                            //     double itemOnScreenWidthX = _renderObjectOriginX(_globalKey);
                            //     if (itemOnScreenWidthX < 10) {
                            //       itemWidthX = itemWidthX + 50.w;
                            //     } else if (itemOnScreenWidthX > 260) {
                            //       itemWidthX = itemWidthX - 50.w;
                            //     }
                            //     debugPrint("偏移量：itemWidthX");
                            //     // 进行跳转
                            //     _scrollController.animateTo(itemWidthX,
                            //         duration: const Duration(milliseconds: 2), curve: Curves.ease);
                            //   }
                            // }

                            for (var item in _dataList) {
                              item['select'] = false;
                            }
                            _dataList[index]['select'] = true;
                            setState(() {});
                            bus.emit('changeBiddingType',
                                {'gtId': _dataList[index]['gtId']});
                            bus.emit('changeInviteType',
                                {'gtId': _dataList[index]['gtId']});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 11.w, vertical: 11.h),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 56.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.h),
                                  color: _dataList[index]['select']
                                      ? const Color(0x20177FF3)
                                      : const Color(0xFFF1F2F6)),
                              child: Row(
                                children: [
                                  Text(
                                    _dataList[index]['gtTypeName'],
                                    style: TextStyle(
                                        fontSize: 28.sp,
                                        color: _dataList[index]['select']
                                            ? const Color(0xFF177FF3)
                                            : const Color(
                                            0xFF1D2023)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ))
          ],
        ));
  }
}
