import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
/// 类似评论框架（包含头像、昵称、内容、时间）
///
class UserMsgRowCell extends StatelessWidget {
  final Widget? lead;
  final String? title;
  final String? date;
  final String? desc;
  final bool reverse;

  const UserMsgRowCell({
    Key? key,
    this.title,
    this.desc,
    this.date,
    this.reverse = false,
    this.lead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      Text(
        title ?? '用户',
        style: StandardTextStyle.normalW,
      ),
      Container(height: 2),
      Text(
        desc ?? '和你打了下招呼',
        style: StandardTextStyle.smallWithOpacity,
      ),
    ];
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reverse ? list.reversed.toList() : list,
    );
    var right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          date ?? '10-12',
          style: StandardTextStyle.smallWithOpacity,
        ),
      ],
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8.h, 10.w, 8.h),
      child: SizedBox(
        height: 80.h,
        width: 80.h,
        child: lead ??
            ClipOval(
              child: Image.network(
                "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
                fit: BoxFit.cover,
              ),
            ),
      ),
    );
    return Tapped(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        child: Row(
          children: <Widget>[
            avatar,
            Expanded(child: info),
            right,
          ],
        ),
      ),
    );
  }
}
