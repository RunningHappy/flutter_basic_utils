import 'dart:convert';
import 'dart:io';
import 'package:app_assembly/app_assembly.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

///
/// 文件操作类 - txt缓存文件读写
///
class IoUtil {
  /// 获取缓存目录
  static Future<String> getTempPath() async {
    var tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  /// 设置缓存
  static void setTempFile(fileName, [str = '']) async {
    String tempPath = await getTempPath();
    await File('$tempPath/$fileName.txt').writeAsString(str);
  }

  /// 读取缓存
  static Future<dynamic> getTempFile(fileName) async {
    String tempPath = await getTempPath();
    try {
      String contents = await File('$tempPath/$fileName.txt').readAsString();
      return jsonDecode(contents);
    } catch (e) {
      debugPrint('$fileName:缓存不存在');
    }
  }

  /// 清缓存
  static void clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      await _delDir(tempDir);
      EasyLoadingHelper.showToast("清除缓存成功");
    } catch (e) {
      EasyLoadingHelper.showToast('清除缓存失败');
    } finally {}
  }

  /// 递归方式删除目录
  static Future<Null> _delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await _delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
