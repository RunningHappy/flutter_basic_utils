import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

///
/// 获取屏幕上获取小部件的绝对坐标
///
Rect globalPaintBounds(GlobalKey key) {
  final renderObject = key.currentContext?.findRenderObject();
  var translation = renderObject?.getTransformTo(null).getTranslation();
  if (translation != null && renderObject!.paintBounds != null) {
    return renderObject.paintBounds.shift(Offset(translation.x, translation.y));
  } else {
    return const Rect.fromLTRB(0, 0, 0, 0);
  }
}

///
/// 解决长数字、字母全部显示省略问题
///
String breakWord(String word) {
  if (word.isEmpty) {
    return word;
  }
  String breakWord = ' ';
  for (var element in word.runes) {
    breakWord += String.fromCharCode(element);
    breakWord += '\u200B';
  }
  return breakWord;
}

///
/// 请求焦点  隐藏键盘
///
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

///
/// 清空输入框
///
void clearInput(TextEditingController controller) {
  // 保证在组件build的第一帧时才去触发取消清空内容
  WidgetsBinding.instance!.addPostFrameCallback((_) => controller.clear());
}

///
/// 返回上一级
///
void back(BuildContext context) {
  hideKeyboard(context);
  Navigator.pop(context);
}

///
/// 回到顶部
///
void toTop(ScrollController scrollController) {
  Future.delayed(const Duration(milliseconds: 20), () {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  });
}

///
/// 回到底部
///
void toBottom(ScrollController scrollController) {
  Future.delayed(const Duration(milliseconds: 20), () {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  });
}

///
/// 请求权限
///
Future<bool> requestPermissions(List<Permission>? permissionList) async {
  Map<Permission, PermissionStatus>? permissions =
      await permissionList!.request();
  List<bool> results = permissions.values.toList().map((status) {
    return status == PermissionStatus.granted;
  }).toList();
  return !results.contains(false);
}


///
/// 格式化数值 - 1000.4万
///
String formatNum(int number) {
  if (number > 10000) {
    var str = _formatNum(number / 10000, 1);
    if (str.split('.')[1] == '0') {
      str = str.split('.')[0];
    }
    return str + '万';
  }
  return number.toString();
}

String _formatNum(double number, int position) {
  if ((number.toString().length - number.toString().lastIndexOf(".") - 1) <
      position) {
    // 小数点后有几位小数
    return (number
        .toStringAsFixed(position)
        .substring(0, number.toString().lastIndexOf(".") + position + 1)
        .toString());
  } else {
    return (number
        .toString()
        .substring(0, number.toString().lastIndexOf(".") + position + 1)
        .toString());
  }
}

///
/// 格式化时间 - 今天、昨天、具体日期
///
String formatTime(int timeSec) {
  var date = DateTime.fromMillisecondsSinceEpoch(timeSec * 1000);
  var now = DateTime.now();
  var yesterday = DateTime.fromMillisecondsSinceEpoch(
      now.millisecondsSinceEpoch - 24 * 60 * 60 * 1000);

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return '今天${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  } else if (date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day) {
    return '昨天${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
  return '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}

///
/// 生成随机串
///
dynamic randomBit(int len, {String? type}) {
  String character = type == 'num'
      ? '0123456789'
      : 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
  String left = '';
  for (var i = 0; i < len; i++) {
    left = left + character[Random().nextInt(character.length)];
  }
  return type == 'num' ? int.parse(left) : left;
}


class NumLengthInputFormatter extends TextInputFormatter {
  late int decimalLength;
  late int integerLength;
  late bool allowInputDecimal;

  NumLengthInputFormatter({this.decimalLength = 2, this.integerLength = 8})
      : super();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (newValue.text.contains('.')) {
      int pointIndex = newValue.text.indexOf('.');
      String beforePoint = newValue.text.substring(0, pointIndex);
      debugPrint(beforePoint);
      //小数点前内容大于integerLength
      if (beforePoint.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      } else
      //小数点前内容小于等于integerLength
      {
        String afterPoint =
            newValue.text.substring(pointIndex + 1, newValue.text.length);
        if (afterPoint.length > decimalLength) {
          value = oldValue.text;
          selectionIndex = oldValue.selection.end;
        }
      }
    } else {
      if (newValue.text.length > integerLength) {
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
