import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'pokemon_store.g.dart';

class PokemonListStore = _PokemonStateBase with _$PokemonListStore;

abstract class _PokemonStateBase with Store {
  @observable
  ObservableList<PokemonEntity> pokemons = ObservableList<PokemonEntity>();

  @action
  void addPokemons(List<PokemonEntity> newPokemons) {
    pokemons.addAll(newPokemons);
  }

  @computed
  int get length => pokemons.length;
}
