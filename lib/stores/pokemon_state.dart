import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_store.dart';
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

  @action
  Future<void> fetchPokemons(ApiRequestParams params) async {
    final newState = await _pokemonUsecase.fetchPokemons(params);
    pokemonState = newState;
  }

  void setupReactions() {
    _dispose = reaction((_) => pokemonState, (newState) {
      return switch (newState) {
        FetchedPokemons(pokemons: final p) => _pokemonListStore.addPokemons(p),
        // TODO - show toast error msg
        ErrorFetchingPokemons(message: final m) => {},
        LoadingPokemons() => {}
      };
    });
  }
}
