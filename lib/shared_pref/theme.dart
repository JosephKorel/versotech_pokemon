import 'package:versotech_pokemon/domain/shared_pref_service.dart';
import 'package:versotech_pokemon/stores/theme.dart';

final class ThemeLocalService {
  const ThemeLocalService(this._localStorageService);
  static const _key = 'theme';

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
