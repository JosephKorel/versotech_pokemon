import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/shared_pref/interface.dart';

class SharedPrefImplementation implements SharedPrefService {
  SharedPrefImplementation({required this.key, this.sharedPreferences})
      : _sharedPreferences =
            sharedPreferences ?? locator.get<SharedPreferences>();

  @override
  final String key;
  final SharedPreferences? sharedPreferences;
  late final SharedPreferences _sharedPreferences;

  @override
  T? getKey<T>() {
    final value = _sharedPreferences.getString(key);

    if (value == null) {
      return null;
    }

    return jsonDecode(value)[key] as T;
  }

  @override
  Future<bool> setKey(Map<String, dynamic> value) async {
    try {
      await _sharedPreferences.setString(key, jsonEncode(value));
      return true;
    } catch (e) {
      return false;
    }
  }
}
