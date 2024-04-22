import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'pokemon_store.g.dart';

class PokemonListState = _PokemonStateBase with _$PokemonListState;

abstract class _PokemonStateBase with Store {
  @observable
  ObservableList<PokemonEntity> pokemons = ObservableList<PokemonEntity>();

  @action
  void addPokemons(List<PokemonEntity> newPokemons) {
    pokemons.addAll(newPokemons);
  }
}

final pokemonState = PokemonListState();
