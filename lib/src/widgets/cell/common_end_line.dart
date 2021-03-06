import 'package:flutter/material.dart';

///
/// 列表底部视图
///
class CommonEndLine extends StatelessWidget {
  const CommonEndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEEEEE),
      padding: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      child: Row(
        children: const <Widget>[
          Expanded(
            child: Divider(height: 10.0,),
            flex: 1,
          ),
          Text("我也是有底线的"),
          Expanded(
            child: Divider(height: 10.0,),
            flex: 1,
          ),
        ],
      ),
    );
  }
}