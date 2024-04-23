import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

part 'fetch_single_pokemon.g.dart';

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

  @computed
  PokemonEntity get pokemon => _loadedPokemonsStore.pokemons
      .where((element) => element.name == (state as LoadedPokemon).pokemon.name)
      .first;

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

  @action
  Future<void> fetchPokemon(String pokemonName) async {
    // Already on the list, no need to fetch it again
    final loadedPokemon = _loadedPokemonsStore.pokemons
        .where((element) => element.name == pokemonName);
    if (loadedPokemon.isNotEmpty) {
      updateState(LoadedPokemon(pokemon: loadedPokemon.first));
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

  void onStateChange() {
    _dispose = reaction((_) => state, (newState) {
      return switch (newState) {
        // Successfully fetched new pokemons, so it will add to the current list
        LoadedPokemon(pokemon: final p) => _loadedPokemonsStore.addPokemon(p),
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
