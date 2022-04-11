import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';

///
/// Form 表单外必须包裹，点击隐藏键盘
///
class FormHideKeyboardWidget extends StatelessWidget {
  final Widget childWidget;
  const FormHideKeyboardWidget({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // 自身和子widget
      child: childWidget,
      onTap: () {
        hideKeyboard(context);
      },
    );
  }
}
