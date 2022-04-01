import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

///
/// 本地数据存储
///
class LocalStorage {
  /// 获取存取数据
  static Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// 设置字符串
  static Future set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  /// 设置存入字符串
  static Future setJSON(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = json.encode(value);

    /// 对value进行编码，将对象传递给json.encode 进行存储
    prefs.setString(key, value);
  }

  static Future getJSON(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    return value != null ? json.decode(value) : null;
  }

  /// 移除存储数据
  static Future removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  /// 清空
  static Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
