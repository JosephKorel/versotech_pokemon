import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_detail_state.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';

import '../usecase/pokemons_usecase_impl_test.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await setUpLocation(testing: true);

  locator.registerLazySingleton<RepositoryInterface>(MockApiRepository.new);

  locator.registerLazySingleton<PokemonUsecaseInterface>(
    MockPokemonUsecaseInterface.new,
  );

  locator.registerLazySingleton<PokemonUsecaseService>(MockPokemonUsecase.new);

  final pokemon = PokemonEntity.mock();
  final singlePokemonStore = locator.get<SinglePokemonStore>();
  final loadedPokemonStore = locator.get<LoadedPokemonStore>();

  setUpAll(() {
    registerFallbackValue(Future.value(LoadedPokemon(pokemon: pokemon)));
  });

  group(
      'Tests for single pokemon store and its interactions with loaded pokemon store',
      () {
    setUp(singlePokemonStore.onStateChange);

    tearDown(() {
      locator.resetLazySingleton<SinglePokemonStore>();
    });

    test('When pokemon state is updated, add it to loaded pokemon store',
        () async {
      // Starts as loading pokemon state and no loaded pokemons
      expect(singlePokemonStore.loading, true);
      expect(loadedPokemonStore.pokemons.isEmpty, true);

      singlePokemonStore.updateState(LoadedPokemon(pokemon: pokemon));

      expect(loadedPokemonStore.pokemons.length, 1);
      singlePokemonStore.reset();
    });

    test(
        'If current pokemon is already in loaded pokemon, does not add it to it',
        () async {
      // Starts as loading pokemon state and no loaded pokemons
      expect(singlePokemonStore.loading, true);

      // Store should still have the pokemon from the first test above
      expect(loadedPokemonStore.pokemons.isEmpty, false);

      singlePokemonStore.updateState(LoadedPokemon(pokemon: pokemon));

      // Already contains it, so the length stays the same
      expect(loadedPokemonStore.pokemons.length, 1);
    });
  });
}
