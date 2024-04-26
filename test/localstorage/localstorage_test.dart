import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/shared_pref/shared_pref.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();

  late final SharedPrefImplementation themeService;
  const mockValue = {'theme': 'dark'};
  const key = 'theme';

  group('Tests for shared preferences', () {
    test('After inserting key, it should appear in key list', () async {
      themeService = SharedPrefImplementation(sharedPrefs);

      final currentKeys = sharedPrefs.getKeys();

      // Starts as a empty list
      expect(currentKeys.length, 0);

      themeService.setKey(key: key, value: mockValue);

      expect(currentKeys.length, 1);
    });
  });
}
