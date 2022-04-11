import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 底部弹出对话框 - 类似点头像打开相册，相机弹窗
///
class MyActionSheet extends StatelessWidget {
  final List<String>? buttonItems;
  final Function? onTap;

  const MyActionSheet({@required this.buttonItems, this.onTap, Key? key})
      : super(key: key);

  /// 取消对话框
  static disMissActionSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showMyActionSheet(BuildContext context, List<String> buttonItems,
      {Function? onTap}) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.h), topRight: Radius.circular(10.h)),
        ),
        isDismissible: true,
        builder: (BuildContext context) {
          return SafeArea(
            child: MyActionSheet(
              buttonItems: buttonItems,
              onTap: onTap,
            ),
          );
        });
  }

  /// 拦截返回键
  Future<bool> _requestPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: _requestPop,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.h), topRight: Radius.circular(10.h)),
          child: Container(
            color: const Color(0xFFF5F5F5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: buttonItems!.map((title) {
                    int index = buttonItems!.indexOf(title);
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        if (onTap != null) {
                          onTap!(index);
                        }
                      },
                      child: _itemCreate(title,
                          isDivider:
                              index == buttonItems!.length - 1 ? false : true),
                    );
                  }).toList(),
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: _itemCreate("取消", isDivider: false),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget _itemCreate(String title, {bool? isDivider}) {
    bool tepIsDivider = isDivider ?? true;
    return Container(
      height: 98.h,
      width: double.infinity,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 32.sp),
          textAlign: TextAlign.center,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
                color:
                    tepIsDivider ? const Color(0xFFDDDDDD) : Colors.transparent,
                width: 0.3)),
      ),
    );
  }
}
