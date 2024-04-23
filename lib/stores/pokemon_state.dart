import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

part 'pokemon_state.g.dart';

class PokemonStateStore = _PokemonStateStoreBase with _$PokemonStateStore;

abstract class _PokemonStateStoreBase with Store {
  final _pokemonUsecase = PokemonUsecase(
    locator.get<PokemonUsecaseInterface>(),
  );
  final _pokemonListStore = locator.get<PokemonListStore>();

  late ReactionDisposer _dispose;

  @observable
  PokemonListState pokemonState = LoadingPokemons();

  @computed
  bool get loading => pokemonState is LoadingPokemons;

  @action
  Future<void> fetchPokemons(ApiRequestParams params) async {
    pokemonState = LoadingPokemons();

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

  // This will run everytime the state of this store changes.
  // Pagination stores changes -> trigger fetchPokemons method ->
  // Update current store state -> React to the state changes
  void onStateChange() {
    _dispose = reaction((_) => pokemonState, (newState) {
      return switch (newState) {
        // Successfully fetched new pokemons, so it will add to the current list
        FetchedPokemons(pokemons: final p) => _pokemonListStore.addPokemons(p),

        // Something went wrong and failed to get pokemons
        // Show snackbar message
        ErrorFetchingPokemons(error: final e) => _showErrorSnackbar(e.message),
        // Doesn't need to do anything, the UI will watch for loading state
        // And show it to the user
        LoadingPokemons() => {}
      };
    });
  }
}
