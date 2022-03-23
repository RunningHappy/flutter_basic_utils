import 'package:app_assembly/app_assembly.dart';
import 'package:app_assembly/src/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自定义 Appbar
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: ColorPlate.back2,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: <Widget>[
            const IosBackButton(),
            Expanded(
              child: Text(
                title ?? '未定标题',
                textAlign: TextAlign.center,
                style: StandardTextStyle.big,
              ),
            ),
            const Opacity(
              opacity: 0,
              child: Icon(
                Icons.panorama_fish_eye,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
