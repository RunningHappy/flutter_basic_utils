import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AndroidBackTop {
  /// 初始化通信管道 - 设置退出到手机桌面
  static const String _channel = "com.p595263720.zit/desktop";

  /// 设置回退到手机桌面
  static Future<bool> backDeskTop() async {
    const platform = MethodChannel(_channel);

    /// 通知安卓返回,到手机桌面
    try {
      final bool out = await platform.invokeMethod('backDesktop');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return Future.value(false);
  }
}
