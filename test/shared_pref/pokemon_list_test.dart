import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/shared_pref/interface.dart';
import 'package:versotech_pokemon/shared_pref/pokemon_list.dart';
import 'package:versotech_pokemon/shared_pref/shared_pref.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await setUpLocation(testing: true);

  SharedPreferences.setMockInitialValues({});

  final sharedPrefs = await SharedPreferences.getInstance();

  const key = 'pokemonList';
  final mockList = [SimplePokemon.mock(), SimplePokemon.mock()];

  locator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  locator.registerLazySingleton<SharedPrefService>(
      () => SharedPrefImplementation(sharedPrefs));
  final themeLocalService = locator.get<PokemonListLocalService>();

  group('Tests for pokemon list local service', () {
    tearDown(() => sharedPrefs.clear());

    test('When theres no pokemon saved, return empty list', () async {
      // No key inserted
      expect(sharedPrefs.containsKey(key), false);

      final savedList = themeLocalService.getPokemons();

      // Should obtain what was saved
      expect(savedList, isA<List<SimplePokemon>>());
      expect(savedList.isEmpty, true);
    });

    test(
        'After inserting mockList, should retrieve a list with the same length',
        () async {
      // No key inserted
      expect(sharedPrefs.containsKey(key), false);

      themeLocalService.setPokemons(mockList);

      final savedList = themeLocalService.getPokemons();

      // Should obtain what was saved
      expect(savedList, isA<List<SimplePokemon>>());
      expect(savedList.length, mockList.length);

      // Should contain the key
      expect(sharedPrefs.containsKey(key), true);
    });
  });
}
