import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';

import '../usecase/pokemons_usecase_impl_test.dart';

void main() {
  setUpLocation(testing: true);

  locator
      .registerLazySingleton<PokemonUsecaseService>(() => MockPokemonUsecase());

  const params = ApiRequestParams(endpoint: '');
  const pokemon = SimplePokemon(name: '', imageUrl: '', id: '');
  final pokemonStateStore = locator.get<PokemonStateStore>();
  final mockUsecase = locator.get<PokemonUsecaseService>();
  final pokemonListStore = locator.get<PokemonListStore>();

  setUpAll(() {
    pokemonStateStore.onStateChange();
  });

  group('Tests for PokemonStateStore', () {
    tearDown(() {
      locator.resetLazySingleton<PokemonStateStore>();
      locator.resetLazySingleton<PokemonUsecaseService>();
      locator.resetLazySingleton<PokemonListStore>();
    });

    test('State should start as loading and then go to FetchedPokemons',
        () async {
      // stub
      when(() => mockUsecase.fetchPokemons(params)).thenAnswer(
          (invocation) async =>
              const FetchedPokemons(pokemons: <SimplePokemon>[]));

      // State starts loading
      expect(pokemonStateStore.loading, true);

      await pokemonStateStore.fetchPokemons(params);

      verify(
        () => mockUsecase.fetchPokemons(params),
      ).called(1);

      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());
    });

    test('When fetched new pokemons, will update the pokemon list store',
        () async {
      // stub
      when(() => mockUsecase.fetchPokemons(params)).thenAnswer(
          (invocation) async =>
              const FetchedPokemons(pokemons: [pokemon, pokemon]));

      // List starts empty
      expect(pokemonListStore.pokemons.isEmpty, true);
      expect(pokemonStateStore.loading, true);

      await pokemonStateStore.fetchPokemons(params);

      verify(
        () => mockUsecase.fetchPokemons(params),
      ).called(1);

      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());
      expect(pokemonListStore.length, 2);
    });

    test('Pokemon list store react to changes in pokemon state store',
        () async {
      // Ensure clean state
      pokemonListStore.reset();
      pokemonStateStore.reset();

      // List starts empty
      expect(pokemonListStore.length, 0);

      expect(pokemonStateStore.loading, true);

      pokemonStateStore
          .setPokemonState(const FetchedPokemons(pokemons: [pokemon, pokemon]));

      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());
      expect(pokemonListStore.length, 2);
    });
  });
}
