///
/// 正则验证
///
class Validator {
  /// 验证银行卡号
  static bool isCardNumber(String input) {
    RegExp mobile = RegExp(r"/^([1-9]{1})(\d{14}|\d{18})$/");
    return mobile.hasMatch(input);
  }

  /// 验证手机号码
  static bool isPhone(String input) {
    RegExp mobile = RegExp(r"1[3-9]\d{9}$");
    return mobile.hasMatch(input);
  }

  /// 6~18位数字和字符组合
  static bool isLoginPassword18(String input) {
    RegExp mobile = RegExp(r"^[0-9a-zA-Z]{6,18}$");
    return mobile.hasMatch(input);
  }

  /// 6~20位数字和字符组合
  static bool isLoginPassword20(String input) {
    RegExp mobile = RegExp(r"^[0-9a-zA-Z]{6,20}$");
    return mobile.hasMatch(input);
  }

  /// 6位数字验证码
  static bool isValidateCaptcha(String input) {
    RegExp mobile = RegExp(r"\d{6}$");
    return mobile.hasMatch(input);
  }

  /// 验证身份证号码
  static bool isIdNum(String input) {
    // RegExp mobile = RegExp(r"(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)");
    RegExp mobile = RegExp(
        r"(^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$)");
    return mobile.hasMatch(input);
  }

  /// 验证汉字2-20位
  static bool isChinaName(String input) {
    RegExp name = RegExp(r"(^[\u4e00-\u9fa5]{2,20}$)");
    return name.hasMatch(input);
  }

  /// 燃油车新车
  static bool isOilTruck(String input) {
    RegExp name = RegExp(r"^([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z0-9]{6})$");
    return name.hasMatch(input);
  }

  /// 新能源车
  static bool isNewEnergyTruck(String input) {
    RegExp name = RegExp(r"^([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z0-9]{7})$");
    return name.hasMatch(input);
  }

  /// 验证车牌号
  static bool isCarNumber(String input) {
    RegExp name = RegExp(
        r'^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z0-9]{7})|[京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新][ABCDEFGHJKLMNPQRSTUVWXY][\dABCDEFGHJKLNMxPQRSTUVWXYZ]{5})$');
    // RegExp name = new RegExp(r"^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z0-9]{7})|[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z0-9]{8})$");
    return name.hasMatch(input);
  }

  /// 发动机编号
  static bool isEngineNum(String input) {
    RegExp name = RegExp(r"^[0-9a-zA-Z]{6}$");
    return name.hasMatch(input);
  }

  bool isNumeric(String str) {
    try {
      var value = double.parse(str);
      return value as bool;
    } on FormatException {
      return false;
    }
  }
}
