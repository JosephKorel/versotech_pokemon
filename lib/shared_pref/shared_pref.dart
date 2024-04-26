import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/shared_pref/interface.dart';

class SharedPrefImplementation implements SharedPrefService {
  SharedPrefImplementation([this.sharedPreferences])
      : _sharedPreferences =
            sharedPreferences ?? locator.get<SharedPreferences>();

  final SharedPreferences? sharedPreferences;
  late final SharedPreferences _sharedPreferences;

  @override
  T? getKey<T>({required String key}) {
    final value = _sharedPreferences.getString(key);

    if (value == null) {
      return null;
    }

    return jsonDecode(value) as T;
  }

  @override
  Future<bool> setKey({required String key, dynamic value}) async {
    try {
      await _sharedPreferences.setString(key, jsonEncode(value));
      return true;
    } catch (e) {
      return false;
    }
  }
}
