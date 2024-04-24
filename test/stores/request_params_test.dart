import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';

import 'locator.dart';

void main() {
  setUpTestingLocation();

  const params = ApiRequestParams(endpoint: '');
  const pokemon = SimplePokemon(name: '', imageUrl: '');
  final pokemonStateStore = testingLocator.get<PokemonStateStore>();
  final mockUsecase = testingLocator.get<PokemonUsecaseInterface>();
  final pokemonListStore = testingLocator.get<PokemonListStore>();
  final paginationStore = testingLocator.get<PaginationStore>();

  setUpAll(() {
    // When initializing the store, pokemon state store will
    // already fetch new pokemons
    pokemonStateStore.onStateChange();
    paginationStore.onPaginationChange();
  });

  tearDown(() {
    testingLocator.resetLazySingleton<PokemonStateStore>();
    testingLocator.resetLazySingleton<PaginationStore>();
    testingLocator.resetLazySingleton<PokemonUsecaseInterface>();
  });

  group('Tests for PaginationStore', () {
    test('When go to next page, set offset to current offset + limit',
        () async {
      // Initial state
      expect(paginationStore.pagination.offset, 0);

      paginationStore.nextPage();

      expect(paginationStore.pagination.offset,
          0 + paginationStore.pagination.limit);

      // Goes back to loading for the next tests
      testingLocator.resetLazySingleton<PokemonStateStore>();
    });

    test(
        'When pagination store change its state, pokemon state store will fetch pokemons and add it to pokemon list store',
        () async {
      // stub
      when(() => mockUsecase.fetchPokemons(params))
          .thenAnswer((invocation) async => [pokemon, pokemon]);

      expect(pokemonStateStore.loading, true);
      expect(paginationStore.pagination.offset, 0);

      // List starts empty
      expect(pokemonListStore.pokemons.isEmpty, true);

      paginationStore.nextPage();

      await Future.delayed(2.seconds);

      verify(
        () => mockUsecase.fetchPokemons(params),
      ).called(1);

      /* expect(store.pokemonState, isA<FetchedPokemons>());
      expect(pokemonListStore.length, 2); */
    });
  });
}
