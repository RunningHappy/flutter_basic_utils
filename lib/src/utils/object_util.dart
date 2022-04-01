///
/// 判断对象是否为空(String List Map),判断两个List是否相等.
///
class ObjectUtil {
  /// 是否是空字符串
  static bool isEmptyString(String? str) {
    return str == null || str.isEmpty;
  }

  /// 是否是空数组
  static bool isEmptyList(Iterable? list) {
    return list == null || list.isEmpty;
  }

  /// 是否是空字典
  static bool isEmptyMap(Map? map) {
    return map == null || map.isEmpty;
  }

  /// 是否是空
  static bool isEmpty(Object? object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is Iterable && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

  /// 是否不是空
  static bool isNotEmpty(Object? object) {
    return !isEmpty(object);
  }

  /// 两个数组是否一样
  static bool twoListIsEqual(List? listA, List? listB) {
    if (listA == listB) return true;
    if (listA == null || listB == null) return false;
    int length = listA.length;
    if (length != listB.length) return false;
    for (int i = 0; i < length; i++) {
      if (!listA.contains(listB[i])) {
        return false;
      }
    }
    return true;
  }

  /// 获取长度
  static int getLength(Object? value) {
    if (value == null) return 0;
    if (value is String) {
      return value.length;
    } else if (value is Iterable) {
      return value.length;
    } else if (value is Map) {
      return value.length;
    } else {
      return 0;
    }
  }
}
