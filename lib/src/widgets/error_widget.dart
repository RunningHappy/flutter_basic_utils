import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 错误 widget
///
initErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint(flutterErrorDetails.toString());
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.error_outline,
              size: 20,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '正在紧张修复中，请返回重试',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  };
}
