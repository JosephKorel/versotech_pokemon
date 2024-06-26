import 'package:flutter_test/flutter_test.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_state.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';

import '../usecase/pokemons_usecase_impl_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await setUpLocation(testing: true);

  locator.registerLazySingleton<RepositoryInterface>(MockApiRepository.new);

  locator.registerLazySingleton<PokemonUsecaseService>(MockPokemonUsecase.new);

  final pokemonStateStore = locator.get<PokemonStateStore>();
  final paginationStore = locator.get<PaginationStore>();
  final pokemonListStore = locator.get<PokemonListStore>();

  group('Tests for PaginationStore', () {
    tearDown(() {
      locator.resetLazySingleton<PokemonStateStore>();
      locator.resetLazySingleton<PaginationStore>();
      locator.resetLazySingleton<PokemonUsecaseInterface>();
      locator.resetLazySingleton<PokemonListStore>();
    });

    test(
        'When go to next page, set offset to current pokemon store list length',
        () async {
      // Initial state
      pokemonListStore
          .addPokemons(List.generate(10, (index) => SimplePokemon.mock()));
      expect(paginationStore.pagination.offset, 0);

      paginationStore.nextPage();

      expect(paginationStore.pagination.offset, pokemonListStore.length);
    });

    test(
        'When pagination store change its state, pokemon state store will fetch pokemons and add it to pokemon list store',
        () async {
      // Set up listener
      paginationStore.onTestCalled();

      // Initial state
      expect(paginationStore.pagination.offset, 0);
      expect(pokemonStateStore.loading, true);
      expect(pokemonListStore.length, 0);

      // Go to next page
      paginationStore.nextPage();

      // Offset should stay the same, trigger pokemon store and trigger
      // pokemon list store
      expect(paginationStore.pagination.offset, 0);
      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());
      expect(pokemonListStore.length, 3);

      // When go to next page, offset should change to 3, which is
      // the length of pokemon store list before update
      paginationStore.nextPage();
      expect(paginationStore.pagination.offset, 3);
    });
  });
}
