import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'fetched_pokemons.g.dart';

class LoadedPokemonStore = _LoadedPokemonStoreBase with _$LoadedPokemonStore;

abstract class _LoadedPokemonStoreBase with Store {
  @observable
  var pokemons = ObservableList<PokemonEntity>();

  @action
  void addPokemon(PokemonEntity pokemon) => pokemons.add(pokemon);
}
