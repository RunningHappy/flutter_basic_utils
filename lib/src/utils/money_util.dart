import 'package:app_assembly/src/utils/number_util.dart';

enum MoneyUnit {
  normal, // 6.00
  yuan, // ¥6.00
  yuanZh, // 6.00元
  dollar, // $6.00
}

enum MoneyFormat {
  normal, // 保留两位小数(6.00元)
  endInteger, // 去掉末尾'0'(6.00元 -> 6元, 6.60元 -> 6.6元)
  yuanInteger, // 整元(6.00元 -> 6元)
}

///
/// 金额格式化
///
class MoneyUtil {
  static const String yuan = '¥';
  static const String yuanZH = '元';
  static const String dollar = '\$';

  /// 分 转 元, format 格式输出.
  static String changeF2Y(int amount,
      {MoneyFormat format = MoneyFormat.normal}) {
    String moneyTxt;
    double yuan = NumUtil.divide(amount, 100);
    switch (format) {
      case MoneyFormat.normal:
        moneyTxt = yuan.toStringAsFixed(2);
        break;
      case MoneyFormat.endInteger:
        if (amount % 100 == 0) {
          moneyTxt = yuan.toInt().toString();
        } else if (amount % 10 == 0) {
          moneyTxt = yuan.toStringAsFixed(1);
        } else {
          moneyTxt = yuan.toStringAsFixed(2);
        }
        break;
      case MoneyFormat.yuanInteger:
        moneyTxt = (amount % 100 == 0)
            ? yuan.toInt().toString()
            : yuan.toStringAsFixed(2);
        break;
    }
    return moneyTxt;
  }

  /// 分字符串 转 元, format 与 unit 格式 输出.
  static String changeFStr2YWithUnit(String amountStr,
      {MoneyFormat format = MoneyFormat.normal,
      MoneyUnit unit = MoneyUnit.normal}) {
    int amount = int.parse(amountStr);
    return changeF2YWithUnit(amount, format: format, unit: unit);
  }

  /// 分 转 元, format 与 unit 格式 输出.
  static String changeF2YWithUnit(int amount,
      {MoneyFormat format = MoneyFormat.normal,
      MoneyUnit unit = MoneyUnit.normal}) {
    return withUnit(changeF2Y(amount, format: format), unit);
  }

  /// 元, format 与 unit 格式 输出.
  static String changeYWithUnit(Object yuan, MoneyUnit unit,
      {MoneyFormat? format}) {
    String yuanTxt = yuan.toString();
    if (format != null) {
      int amount = changeY2F(yuan);
      yuanTxt = changeF2Y(amount.toInt(), format: format);
    }
    return withUnit(yuanTxt, unit);
  }

  /// 元 转 分
  static int changeY2F(Object yuan) {
    return NumUtil.multiplyDecStr(yuan.toString(), '100').toInt();
  }

  /// 拼接单位.
  static String withUnit(String moneyTxt, MoneyUnit unit) {
    switch (unit) {
      case MoneyUnit.yuan:
        moneyTxt = yuan + moneyTxt;
        break;
      case MoneyUnit.yuanZh:
        moneyTxt = moneyTxt + yuanZH;
        break;
      case MoneyUnit.dollar:
        moneyTxt = dollar + moneyTxt;
        break;
      default:
        break;
    }
    return moneyTxt;
  }
}
