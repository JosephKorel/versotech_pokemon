interface class SharedPrefService {
  String get key => throw UnimplementedError();

  T? getKey<T>() => throw UnimplementedError();

  Future<bool> setKey(Map<String, dynamic> value) => throw UnimplementedError();
}
