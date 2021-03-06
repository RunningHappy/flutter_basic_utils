import 'package:app_assembly/src/widgets/toast/loading_dialog.dart';
import 'package:flutter/material.dart';

abstract class HQDialog {
  // 默认弹窗alert
  static void alert(context,
      {required String text,
        String title = '提示',
        String yes = '确定',
        Function? yesCallBack}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(yes),
              onPressed: () {
                if (yesCallBack != null) yesCallBack();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {});
  }

  // loadingDialog
  static void showLoading(context, {String title = '正在加载...'}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            text: title,
          );
        });
  }
}