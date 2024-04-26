import 'package:versotech_pokemon/shared_pref/interface.dart';
import 'package:versotech_pokemon/stores/theme.dart';

final class ThemeLocalService {
  static const _key = 'theme';
  const ThemeLocalService(this._localStorageService);

  final SharedPrefService _localStorageService;

  ThemeOptions getTheme() {
    final value = _localStorageService.getKey<String>(key: _key);

    // If there's nothing saved yet, go back to system preference
    if (value == null) {
      return ThemeOptions.system;
    }

    return ThemeOptions.values.where((element) => element.name == value).first;
  }

  Future<bool> setTheme(ThemeOptions theme) async =>
      _localStorageService.setKey(key: _key, value: theme.name);
}
