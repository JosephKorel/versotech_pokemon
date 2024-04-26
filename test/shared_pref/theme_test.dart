import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/domain/shared_pref_service.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/shared_pref/shared_pref_impl.dart';
import 'package:versotech_pokemon/shared_pref/theme.dart';
import 'package:versotech_pokemon/stores/theme.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await setUpLocation(testing: true);

  SharedPreferences.setMockInitialValues({});

  final sharedPrefs = await SharedPreferences.getInstance();

  const key = 'theme';

  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  locator.registerLazySingleton<SharedPrefService>(
    () => SharedPrefImplementation(sharedPrefs),
  );
  final themeLocalService = locator.get<ThemeLocalService>();

  group('Tests for theme local service', () {
    tearDown(sharedPrefs.clear);

    test('Should insert and retrieve ThemeOptions', () {
      // No key inserted
      expect(sharedPrefs.containsKey(key), false);

      // Save theme
      themeLocalService.setTheme(ThemeOptions.dark);

      // Should obtain what was saved
      expect(themeLocalService.getTheme(), ThemeOptions.dark);

      // Should contain the key
      expect(sharedPrefs.containsKey(key), true);
    });

    test('Should insert and retrieve ThemeOptions', () {
      // No key inserted
      expect(sharedPrefs.containsKey(key), false);

      // When there's no theme saved, return system option
      expect(themeLocalService.getTheme(), ThemeOptions.system);
    });
  });
}
