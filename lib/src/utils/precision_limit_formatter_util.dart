import 'package:flutter/services.dart';

class PrecisionLimitFormatter extends TextInputFormatter {
  final int _scale;

  PrecisionLimitFormatter(this._scale);

  RegExp exp = RegExp("[0-9.]");
  static const String pointer = ".";
  static const String doubleZero = "00";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.startsWith(pointer) && newValue.text.length == 1) {
      /// 第一个不能输入小数点
      return oldValue;
    }

    /// 输入完全删除
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    /// 只允许输入小数
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    /// 包含小数点的情况
    if (newValue.text.contains(pointer)) {
      /// 包含多个小数
      if (newValue.text.indexOf(pointer) !=
          newValue.text.lastIndexOf(pointer)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(pointer);

      /// 小数点后位数
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      /// 小数位大于精度
      if (lengthAfterPointer > _scale) {
        return oldValue;
      }
    } else {
      if (newValue.text.length > 1) {
        if (newValue.text.startsWith('0')) {
          return TextEditingValue(
              text: newValue.text.substring(1, newValue.text.length),
              selection: TextSelection.collapsed(
                  offset:
                      newValue.text.substring(1, newValue.text.length).length));
        } else {
          return newValue;
        }
      } else {
        if (newValue.text.startsWith(pointer) ||
            newValue.text.startsWith(doubleZero)) {
          /// 不包含小数点,不能以“00”开头
          return oldValue;
        } else {
          return newValue;
        }
      }
    }
    return const TextEditingValue(text: '');
    // else if (newValue.text.startsWith(POINTER) || newValue.text.startsWith(DOUBLE_ZERO)) {
    //   return oldValue;
    // }
    // return newValue;
    //   {
    //   if(newValue.text.length > 1){
    //     if(newValue.text.startsWith('0')){
    //       return oldValue;
    //     }else{
    //       return newValue;
    //     }
    //   }else{
    //     if (newValue.text.startsWith(POINTER) || newValue.text.startsWith(DOUBLE_ZERO)) {
    //       ///不包含小数点,不能以“00”开头
    //       return oldValue;
    //     }else{
    //       return newValue;
    //     }
    //   }
    // }
  }
}
