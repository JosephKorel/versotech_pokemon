import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_detail_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/request_params.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/utils/navigation.dart';

part 'single_pokemon.g.dart';

// This store is responsible for fetching the pokemon details when the user taps the
// pokemon and navigate to its page. Although the store, once it has successfully
// loaded the pokemon, will have the pokemon avaiable, all widgets will read the pokemon from
// the LoadedPokemonStore, to ensure a single source of truth
class SinglePokemonStore = _SinglePokemonStoreBase with _$SinglePokemonStore;

abstract class _SinglePokemonStoreBase with Store {
  // Dependencies
  final _pokemonUsecase = locator.get<PokemonUsecaseService>();
  final _loadedPokemonsStore = locator.get<LoadedPokemonStore>();
  //

  @observable
  SinglePokemonState state = LoadingPokemon();

  @computed
  bool get loading => state is LoadingPokemon;

  // Since this method will only be used in the pokemon screen,
  // it's safe to assume that the state will be LoadedPokemon
  @computed
  PokemonEntity get pokemon => _loadedPokemonsStore.pokemons
      .where((element) => element.name == (state as LoadedPokemon).pokemon.name)
      .first;

  @computed
  bool get hasActivePokemon => state is LoadedPokemon;

  @action
  void reset() => state = LoadingPokemon();

  @action
  void updateState(SinglePokemonState newState) => state = newState;

  void _showErrorSnackbar(String errorMsg) => locator
      .get<GlobalKey<NavigatorState>>()
      .currentContext!
      .showSnackbar(errorMsg);

  bool _pokemonAlreadyLoaded(String pokemonName) =>
      _loadedPokemonsStore.pokemons
          .any((element) => element.name == pokemonName);

  // This will run everytime the state changed to LoadedPokemon (success state)
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
    final newState = await _pokemonUsecase.fetchSinglePokemon(
      SinglePokemonRequest.fromName(pokemonName),
    );
    updateState(newState);
  }

  // When the user taps the pokemon card, it will call fetchPokemon method
  // thus triggering the state change
  void onStateChange() {
    final _ = reaction((_) => state, (newState) {
      return switch (newState) {
        // Loaded pokemon from the api or just retrieved from the list
        LoadedPokemon(pokemon: final p) => _onLoadedPokemon(p),

        // Something went wrong and failed to get pokemons
        // Show snackbar message
        FailedToGetPokemon(error: final e) => _showErrorSnackbar(e.message),

        // Doesn't need to do anything, the UI will watch for loading state
        // And show it to the user
        (_) => {}
      };
    });
  }
}
