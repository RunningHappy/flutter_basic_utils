import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_assembly/src/widgets/pop_alert/basic_bottom_sheet.dart'
    as custom_bottom_sheet;

/// 底部弹出评论sheet（包含头像、昵称、内容、时间）
class CommentBottomSheet extends Dialog {
  const CommentBottomSheet({
    Key? key,
  }) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 显示对话框
  static showCommentDialog(BuildContext context,
      {Function? onTap}) {
    custom_bottom_sheet.showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) => const CommentBottomSheetContent(),
    );
  }
}

class CommentBottomSheetContent extends StatelessWidget {
  const CommentBottomSheetContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: ColorPlate.back1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.h)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(4.h),
            height: 4.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 24,
            alignment: Alignment.center,
            // color: Colors.white.withOpacity(0.2),
            child: const Text(
              '128条评论',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: const <Widget>[
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
                _CommentRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '是假用户哟',
          style: StandardTextStyle.smallWithOpacity,
        ),
        Container(height: 2.h),
        const Text(
          '这是一条模拟评论，主播666啊。',
          style: StandardTextStyle.smallWithOpacity,
        ),
      ],
    );
    Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        Text(
          '54',
          style: StandardTextStyle.smallWithOpacity,
        ),
      ],
    );
    right = Opacity(
      opacity: 0.3,
      child: right,
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8.w, 10.h, 8.w),
      child: SizedBox(
        height: 36,
        width: 36,
        child: ClipOval(
          child: Image.network(
            "https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Row(
        children: <Widget>[
          avatar,
          Expanded(child: info),
          right,
        ],
      ),
    );
  }
}
