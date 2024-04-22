import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'pokemon_store.g.dart';

class PokemonListStore = _PokemonStateBase with _$PokemonListStore;

abstract class _PokemonStateBase with Store {
  @observable
  ObservableList<SimplePokemonEntity> pokemons =
      ObservableList<SimplePokemonEntity>();

  @action
  void addPokemons(List<SimplePokemonEntity> newPokemons) {
    pokemons.addAll(newPokemons);
  }

  @computed
  int get length => pokemons.length;
}
