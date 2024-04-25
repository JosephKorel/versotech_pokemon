import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'fetched_pokemons.g.dart';

// This store holds the list of every pokemon the user tapped.
// The main goal of this store is to prevent that users keep fetching the same
// pokemon.
class LoadedPokemonStore = _LoadedPokemonStoreBase with _$LoadedPokemonStore;

abstract class _LoadedPokemonStoreBase with Store {
  @observable
  var pokemons = ObservableList<PokemonEntity>();

  @action
  void reset() => pokemons.clear();

  @action
  void addPokemon(PokemonEntity pokemon) => pokemons.add(pokemon);

  // TODO - implement local storage interaction
}
