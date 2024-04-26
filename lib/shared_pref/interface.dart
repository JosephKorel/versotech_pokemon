interface class SharedPrefService {
  T? getKey<T>({required String key}) => throw UnimplementedError();

  Future<bool> setKey({required String key, dynamic value}) =>
      throw UnimplementedError();
}
