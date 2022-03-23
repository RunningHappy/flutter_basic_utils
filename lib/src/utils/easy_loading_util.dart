import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingHelper {
  static showLoading(String? msg) {
    EasyLoading.show(
        status: msg ?? '加载中...', maskType: EasyLoadingMaskType.clear);
  }

  static showToast(String msg, {String error = "网络错误"}) {
    EasyLoading.showToast(msg.isEmpty ? error : msg);
  }

  static showProgress(double progress, String proMsg) {
    EasyLoading.showProgress(progress, status: proMsg);
  }

  static showSuccess(String success) {
    EasyLoading.showSuccess(success);
  }

  static showError(String err) {
    EasyLoading.showError(err);
  }

  static dismiss() {
    EasyLoading.dismiss();
  }
}
