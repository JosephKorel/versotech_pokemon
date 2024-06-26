import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';

part 'fetched_pokemons.g.dart';

// This store holds the list of every pokemon the user tapped.
// The main goal of this store is to prevent that users keep fetching the same pokemon
class LoadedPokemonStore = _LoadedPokemonStoreBase with _$LoadedPokemonStore;

abstract class _LoadedPokemonStoreBase with Store {
  @observable
  ObservableList<PokemonEntity> pokemons = ObservableList<PokemonEntity>();

  @action
  void reset() => pokemons = <PokemonEntity>[].asObservable();

  @computed
  PokemonEntity get currentPokemon {
    final pokemonStore = locator.get<SinglePokemonStore>();
    return pokemons.firstWhere((element) => pokemonStore.pokemon == element);
  }

  // Will only be called when there's an active pokemon
  @computed
  List<Ability> get pokemonAbilities {
    final pokemonStore = locator.get<SinglePokemonStore>();
    return pokemons
        .firstWhere((element) => element == pokemonStore.pokemon)
        .abilities;
  }

  @computed
  List<Characteristic> get pokemonCharacteristics {
    final pokemonStore = locator.get<SinglePokemonStore>();
    return pokemons
        .firstWhere((element) => element == pokemonStore.pokemon)
        .characteristics;
  }
  //

  // Everytime user reads an ability, save the description to prevent
  // calling the api again
  @action
  void updatePokemonAbility({required Ability ability}) {
    final pokemonStore = locator.get<SinglePokemonStore>();

    pokemons = pokemons
        .map(
          (element) => element.name != pokemonStore.pokemon.name
              ? element
              : element.copyWith(
                  abilities: element.abilities
                      .map((e) => e.name == ability.name ? ability : e)
                      .toList(),
                ),
        )
        .toList()
        .asObservable();
  }

  @action
  void updatePokemonCharacteristic({
    required List<Characteristic> characteristics,
  }) {
    final pokemonStore = locator.get<SinglePokemonStore>();

    pokemons = pokemons
        .map(
          (element) => element.name != pokemonStore.pokemon.name
              ? element
              : element.copyWith(characteristics: characteristics),
        )
        .toList()
        .asObservable();
  }

  @action
  void addPokemon(PokemonEntity pokemon) => pokemons.add(pokemon);
}
