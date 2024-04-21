import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';

part 'pokemon_state.g.dart';

class PokemonStateStore = _PokemonStateStoreBase with _$PokemonStateStore;

abstract class _PokemonStateStoreBase with Store {
  @observable
  PokemonListState pokemonState = LoadingPokemons();
}
