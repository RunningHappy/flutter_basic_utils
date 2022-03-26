import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';

enum BasicPageTag {
  home,
  follow,
  msg,
  me,
}

/// 基础 TabBar
class BasicTabBar extends StatelessWidget {
  final Function(BasicPageTag)? onTabSwitch;
  final Function()? onAddButton;

  final bool hasBackground;
  final BasicPageTag? current;

  const BasicTabBar({
    Key? key,
    this.onTabSwitch,
    this.current,
    this.onAddButton,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    Widget row = Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == BasicPageTag.home,
              title: '首页',
            ),
            onTap: () => onTabSwitch?.call(BasicPageTag.home),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == BasicPageTag.follow,
              title: '关注',
            ),
            onTap: () => onTabSwitch?.call(BasicPageTag.follow),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: const Icon(
              Icons.add_box,
              size: 32,
            ),
            onTap: () => onAddButton?.call(),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == BasicPageTag.msg,
              title: '消息',
            ),
            onTap: () => onTabSwitch?.call(BasicPageTag.msg),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == BasicPageTag.me,
              title: '我',
            ),
            onTap: () => onTabSwitch?.call(BasicPageTag.me),
          ),
        ),
      ],
    );
    return Container(
      color: hasBackground ? ColorPlate.back2 : ColorPlate.back2.withOpacity(0),
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 50 + padding.bottom,
        child: row,
      ),
    );
  }
}