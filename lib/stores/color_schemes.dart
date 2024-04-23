import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_color.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/theme/color_schemes.g.dart';

part 'color_schemes.g.dart';

// Each pokemon will have a color based on its image. To prevent fetching
// its color scheme repeatdly, this store will hold all color schemes
class ColorSchemesStore = _ColorSchemesStoreBase with _$ColorSchemesStore;

abstract class _ColorSchemesStoreBase with Store {
  final _pokemonStore = locator.get<FetchSinglePokemonStore>();

  @observable
  var colorSchemes = ObservableList<PokemonColor>();

  @action
  void addColor(PokemonColor color) => colorSchemes.add(color);

  // _pokemonStore will only be LoadedPokemon when the user gets in
  // the pokemon page, so here we return the color scheme of that pokemon
  @computed
  ColorScheme get colorScheme => _pokemonStore is LoadedPokemon
      ? colorSchemes
          .where((element) => element.name == (_pokemonStore.pokemon.name))
          .first
          .colorScheme
      : lightColorScheme;

  // Method to get the color scheme from the pokemon image
  @action
  Future<void> getPokemonTheme(SimplePokemon pokemon) async {
    PokemonColor pokemonColor;

    try {
      final pokemonColorScheme = await ColorScheme.fromImageProvider(
          provider: NetworkImage(pokemon.imageUrl));

      pokemonColor =
          PokemonColor(name: pokemon.name, colorScheme: pokemonColorScheme);
    } catch (e) {
      // Fallback to original color scheme
      pokemonColor =
          PokemonColor(name: pokemon.name, colorScheme: lightColorScheme);
    }
    addColor(pokemonColor);
  }
}
