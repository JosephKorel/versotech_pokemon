import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_list_state.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_store.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

part 'pokemon_list_state.g.dart';

class PokemonStateStore = _PokemonStateStoreBase with _$PokemonStateStore;

abstract class _PokemonStateStoreBase with Store {
  final _pokemonUsecase = locator.get<PokemonUsecase>();
  final _pokemonListStore = locator.get<PokemonListStore>();

  late ReactionDisposer _dispose;

  @observable
  PokemonListState pokemonState = LoadingPokemons();

  @computed
  bool get loading => pokemonState is LoadingPokemons;

  @action
  Future<void> fetchPokemons(ApiRequestParams params) async {
    final newState = await _pokemonUsecase.fetchPokemons(params);
    pokemonState = newState;
  }

  void _showErrorSnackbar(String errorMsg) {
    final context = locator.get<GlobalKey<NavigatorState>>().currentContext!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
      ),
    );
  }

  void onStateChange() {
    _dispose = reaction((_) => pokemonState, (newState) {
      return switch (newState) {
        // Successfully fetched new pokemons, so it will add to the current list
        FetchedPokemons(pokemons: final p) => _pokemonListStore.addPokemons(p),

        // Something went wrong and failed to get pokemons
        // Show snackbar message
        ErrorFetchingPokemons(message: final m) => _showErrorSnackbar(m),
        // Doesn't need to do anything, the UI will watch for loading state
        // And show it to the user
        LoadingPokemons() => {}
      };
    });
  }
}
