import 'package:flutter/services.dart';

///
/// 打印类，目前只写了 android channel
/// 
class LogUtil {
  static const String _tag = "LogUtils";
  static const _perform = MethodChannel("com.p595263720.zit/log");

  static void d(String message) {
    _perform.invokeMethod("logD", {'tag': _tag, 'msg': message});
  }

  static void e(String message) {
    _perform.invokeMethod("logE", {'tag': _tag, 'msg': message});
  }
}
