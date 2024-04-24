import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/shared_pref/shared_pref.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();

  late final SharedPrefImplementation themeService;
  const mockValue = {'theme': 'dark'};

  group('Tests for shared preferences', () {
    test('After inserting key, it should appear in key list', () async {
      themeService = SharedPrefImplementation(
          key: 'theme', sharedPreferences: sharedPrefs);

      final currentKeys = sharedPrefs.getKeys();

      // Starts as a empty list
      expect(currentKeys.length, 0);

      themeService.setKey(mockValue);

      expect(currentKeys.length, 1);
    });
  });
}
