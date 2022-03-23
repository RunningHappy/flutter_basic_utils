import 'dart:io';
import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/material.dart';

/// 弹出文件下载组件
class PopDownloadFileAlert extends Dialog {
  const PopDownloadFileAlert({
    Key? key,
  }) : super(key: key);

  /// 取消对话框
  static disMissDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // 显示对话框
  static showMyConfirmDialog(BuildContext context,
      {String? name, String? msgContent, Function(String path)? onTap}) {
    MyConfirmDialog.showMyConfirmDialog(context, ['取消', '下载'],
        title: '', content: msgContent ?? '您下载查看合同吗？', onTap: (index) {
      Navigator.pop(context);
      if (index == 1) {
        _createPath(context, name, onTap: onTap);
      }
    });
  }

  static _createPath(context, name, {Function(String path)? onTap}) async {
    /// 申请写文件权限
    bool isPermission = await requestPermissions([Permission.storage]);
    String _localPath = "";
    if (isPermission) {
      Directory _path = await getApplicationDocumentsDirectory();
      _localPath = _path.path + Platform.pathSeparator + 'Download';
      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }

      if (_localPath.isNotEmpty) {
        onTap!.call(_localPath + "/" + name);
      }
    } else {
      // 提示用户请同意权限申请
      isPermission = await requestPermissions([Permission.storage]);
    }
    debugPrint("路径" + _localPath);
  }
}
