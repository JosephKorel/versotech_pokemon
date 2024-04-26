import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/shared_pref/pokemon_list.dart';

part 'pokemon_simple_store.g.dart';

// This store will hold the pokemons that appear on the home screen
class PokemonListStore = _PokemonStateBase with _$PokemonListStore;

abstract class _PokemonStateBase with Store {
  final _pokemonListLocalService = locator.get<PokemonListLocalService>();
  late ReactionDisposer _dispose;

  @observable
  ObservableList<SimplePokemon> pokemons = ObservableList<SimplePokemon>();

  @action
  void addPokemons(List<SimplePokemon> newPokemons) {
    pokemons = [...pokemons, ...newPokemons].asObservable();
  }

  @action
  void getSavedPokemons() =>
      pokemons = _pokemonListLocalService.getPokemons().asObservable();

  @action
  void reset() => pokemons = <SimplePokemon>[].asObservable();

  @computed
  int get length => pokemons.length;

  void onStateChange() {
    _dispose = reaction((p0) => pokemons, (addedPokemons) {
      // Save pokemons in local storage
      _pokemonListLocalService.setPokemons(addedPokemons);
    });
  }
}
