import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';

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

  // Will only be called when there's an active pokemon
  @computed
  List<Ability> get pokemonAbilities {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();
    return pokemons
        .firstWhere((element) => element == pokemonStore.pokemon)
        .abilities;
  }

  // Everytime user reads an ability, save the description to prevent
  // calling the api again
  @action
  void updatePokemonAbility({required Ability ability}) {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

    pokemons = pokemons
        .map((element) => element.name != pokemonStore.pokemon.name
            ? element
            : element.copyWith(
                abilities: element.abilities
                    .map((e) => e.name == ability.name ? ability : e)
                    .toList()))
        .toList()
        .asObservable();
  }

  @action
  void addPokemon(PokemonEntity pokemon) => pokemons.add(pokemon);
}
