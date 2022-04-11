import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 横向滚动 tab
///
class HorizontalScrollSegment extends StatefulWidget
    implements PreferredSizeWidget {
  final BuildContext? context;
  final List dataList;
  const HorizontalScrollSegment({Key? key, required this.context, required this.dataList})
      : super(key: key);

  @override
  _HorizontalScrollSegmentState createState() =>
      _HorizontalScrollSegmentState();

  @override
  Size get preferredSize {
    return Size(MediaQuery.of(context!).size.width, 80.h);
  }
}

class _HorizontalScrollSegmentState extends State<HorizontalScrollSegment> {
  // {'gtTypeName': '全部', 'select': true, 'gtId': 0}
  List _dataList = [];
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = <GlobalKey>[];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bus.off('updateTypes');
    bus.off('refreshTypes');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      getListContent();
    });
    _initEvent();
  }

  _initEvent() {
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
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
        setState(() {});
        // bus.emit('changeBiddingType',{'gtId':0});
        // bus.emit('changeInviteType',{'gtId':0});
      }
    });
  }

  getListContent() async {
    setState(() {
      _dataList = widget.dataList;
      for(int i = 0;i < _dataList.length; i++) {
        _keys.add(GlobalKey(debugLabel:i.toString()));
      }
    });
  }

  // 滚动 Item 到指定位置，这里滚动到屏幕正中间，横向滚动的
  void _scrollItemToCenter(int pos) {
    if (_keys.isEmpty) return;

    // 获取 item 的尺寸和位置
    RenderBox box = _keys[pos].currentContext!.findRenderObject() as RenderBox;
    Offset os = box.localToGlobal(Offset.zero);

    double w = box.size.width;
    double x = os.dx;

    // 获取屏幕宽高
    double windowW = MediaQuery.of(context).size.width;

    // 就算当前 item 距离屏幕中央的相对偏移量
    double rlOffset = windowW / 2 - (x + w / 2);

    // 计算 _controller 应该滚动的偏移量
    double offset = _scrollController.offset - rlOffset;
    debugPrint("偏移量：$offset");
    if (offset < 0) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    } else {
      if (pos != _keys.length - 1) {
        _scrollController.animateTo(offset,
            duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      }
    }
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
                        return GestureDetector(
                          key: _keys[index],
                          onTap: () {
                            _scrollItemToCenter(index);
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
