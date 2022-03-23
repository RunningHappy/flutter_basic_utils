class Bundle {
  final Map<String, dynamic> _map = {};

  _setValue(var k, var v) => _map[k] = v;

  _getValue(String k) {
    if (!_map.containsKey(k)) {
      throw Exception("您使用的$k不存在！请检查key名字");
    }
    return _map[k];
  }

  putInt(String k, int v) => _map[k] = v;

  putString(String k, String v) => _setValue(k, v);

  putBool(String k, bool v) => _setValue(k, v);

  putList<V>(String k, List<V> v) => _setValue(k, v);

  putMap<K, V>(String k, Map<K, V> v) => _setValue(k, v);

  putObj<T>(String k, T v) => _setValue(k, v);

  getInt(String k) => _getValue(k) as int;

  getString(String k) => _getValue(k) as String;

  getBool(String k) => _getValue(k) as bool;

  getList(String k) => _getValue(k) as List;

  getMap(String k) => _getValue(k) as Map;

  getObj<T>(String k) => _getValue(k) as T;

  @override
  String toString() {
    // TODO: implement toString
    return _map.toString();
  }
}
