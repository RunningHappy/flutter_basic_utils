import 'package:flutter/services.dart';

///
/// TextField 输入小数的自定义 formatter
///
class MyNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  /// 允许的小数位数，-1代表不限制位数
  int digit;

  /// 是否可输入负数
  bool canInputMinus;

  MyNumberTextInputFormatter({this.digit = -1, this.canInputMinus = false});

  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  /// 获取目前的小数位数
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;

    /// 负数取绝对值
    if (value.contains('-') && value.length >= 2) {
      value = num.parse(newValue.text).abs().toString();
      selectionIndex = value.length;
    }

    if (canInputMinus) {
      if (value == ".") {
        value = "0.";
        selectionIndex++;
      } else if (value == "-") {
        value = "-";
        selectionIndex++;
      } else if (value != "" &&
              value != defaultDouble.toString() &&
              strToFloat(value, defaultDouble) == defaultDouble ||
          getValueDigit(value) > digit) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    } else {
      if (value == ".") {
        value = "0.";
        selectionIndex++;
      } else if (value != "" &&
              value != defaultDouble.toString() &&
              strToFloat(value, defaultDouble) == defaultDouble ||
          getValueDigit(value) > digit) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
