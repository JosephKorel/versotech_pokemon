import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';

import 'locator.dart';

void main() {
  setUpTestingLocation();

  const params = ApiRequestParams(endpoint: '');
  const pokemon = SimplePokemon(name: '', imageUrl: '');
  final pokemonStateStore = testingLocator.get<PokemonStateStore>();
  final mockUsecase = testingLocator.get<PokemonUsecaseInterface>();
  final pokemonListStore = testingLocator.get<PokemonListStore>();

  setUpAll(() {
    pokemonStateStore.onStateChange();
  });

  group('Tests for PokemonStateStore', () {
    test('State should start as loading and then go to FetchedPokemons',
        () async {
      // stub
      when(() => mockUsecase.fetchPokemons(params))
          .thenAnswer((invocation) async => <SimplePokemon>[]);

      // State starts loading
      expect(pokemonStateStore.loading, true);

      await pokemonStateStore.fetchPokemons(params);

      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());

      // Goes back to loading for the next tests
      pokemonStateStore.reset();
    });

    test('When fetched new pokemons, will update the pokemon list store',
        () async {
      // stub
      when(() => mockUsecase.fetchPokemons(params))
          .thenAnswer((invocation) async => [pokemon, pokemon]);

      // List starts empty
      expect(pokemonListStore.pokemons.isEmpty, true);
      expect(pokemonStateStore.loading, true);

      await pokemonStateStore.fetchPokemons(params);

      expect(pokemonStateStore.pokemonState, isA<FetchedPokemons>());
      expect(pokemonListStore.length, 2);
    });
  });
}
