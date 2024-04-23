import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';

part 'pokemon_simple_store.g.dart';

// This store will hold the pokemons that appear on the home screen
class PokemonListStore = _PokemonStateBase with _$PokemonListStore;

abstract class _PokemonStateBase with Store {
  @observable
  ObservableList<SimplePokemon> pokemons = ObservableList<SimplePokemon>();

  @action
  void addPokemons(List<SimplePokemon> newPokemons) {
    pokemons.addAll(newPokemons);
  }

  @computed
  int get length => pokemons.length;
}
