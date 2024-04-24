import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

part 'fetch_single_pokemon.g.dart';

// This store is responsible for fetching the pokemon details
// when the user taps the pokemon and navigate to its page.
// Although the store when successfully loaded the pokemon has
// the loaded pokemon avaiable, all widgets will read the pokemon from
// the LoadedPokemonStore, to ensure a single source of truth
class FetchSinglePokemonStore = _FetchSinglePokemonStoreBase
    with _$FetchSinglePokemonStore;

abstract class _FetchSinglePokemonStoreBase with Store {
  // Dependencies
  final _pokemonUsecase = locator.get<PokemonUsecase>();
  final _loadedPokemonsStore = locator.get<LoadedPokemonStore>();
  //

  late ReactionDisposer _dispose;

  @observable
  SinglePokemonState state = LoadingPokemon();

  // Since this method will only be used in the pokemon screen,
  // it's safe to assume that the state will be LoadedPokemon
  @computed
  PokemonEntity get pokemon => _loadedPokemonsStore.pokemons
      .where((element) => element.name == (state as LoadedPokemon).pokemon.name)
      .first;

  @computed
  bool get hasActivePokemon => state is LoadedPokemon;

  @action
  void updateState(SinglePokemonState newState) => state = newState;

  void _showErrorSnackbar(String errorMsg) {
    final context = locator.get<GlobalKey<NavigatorState>>().currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
      ),
    );
  }

  bool _pokemonAlreadyLoaded(String pokemonName) =>
      _loadedPokemonsStore.pokemons
          .any((element) => element.name == pokemonName);

  void _onLoadedPokemon(PokemonEntity pokemon) {
    if (_pokemonAlreadyLoaded(pokemon.name)) {
      return;
    }

    _loadedPokemonsStore.addPokemon(pokemon);
  }

  @action
  Future<void> fetchPokemon(String pokemonName) async {
    if (_pokemonAlreadyLoaded(pokemonName)) {
      final pokemon = _loadedPokemonsStore.pokemons
          .where((element) => element.name == pokemonName)
          .first;

      updateState(
        LoadedPokemon(pokemon: pokemon),
      );
      return;
    }

    // Is not yet on the list, will fetch it
    final newState = await _pokemonUsecase.fetchSinglePokemons(
      SinglePokemonRequest.fromName(pokemonName),
    );
    updateState(newState);
  }

  @action
  void clear() => state = LoadingPokemon();

  // When the user taps the pokemon card, it will call fetchPokemon method
  // thus triggering the state change
  void onStateChange() {
    _dispose = reaction((_) => state, (newState) {
      return switch (newState) {
        // Loaded pokemon from the api or just retrieved from the list
        LoadedPokemon(pokemon: final p) => _onLoadedPokemon(p),

        // Something went wrong and failed to get pokemons
        // Show snackbar message
        FailedToGetPokemon(error: final e) => _showErrorSnackbar(e.message),

        // Doesn't need to do anything, the UI will watch for loading state
        // And show it to the user
        LoadingPokemon() => {}
      };
    });
  }
}
