import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/theme/color_schemes.g.dart';

part 'pokemon_details.g.dart';

// The purpose of this store is to hold the pokemon being viewed
// so we won't have to pass the same pokemon props down the widget tree
class PokemonDetailsStore = _PokemonDetailsStoreBase with _$PokemonDetailsStore;

abstract class _PokemonDetailsStoreBase with Store {
  late final ReactionDisposer _dispose;

  @observable
  PokemonEntity? pokemon;

  @observable
  ColorScheme? colorScheme;

  @action
  void setColorScheme(ColorScheme pokemonColorScheme) =>
      colorScheme = pokemonColorScheme;

  @action
  void setPokemon(PokemonEntity selectedPokemon) => pokemon = selectedPokemon;

  @action
  void clear() {
    pokemon = null;
    colorScheme = null;
  }

  @computed
  bool get loadingColorScheme => colorScheme == null;

  @computed
  bool get noPokemon => pokemon == null;

  void onStateChange() {
    _dispose = reaction((p0) => pokemon, (p0) async {
      if (pokemon == null) {
        return;
      }

      final pokemonColorScheme = await _getPokemonTheme(pokemon!);
      setColorScheme(pokemonColorScheme);
    });
  }

  Future<ColorScheme> _getPokemonTheme(PokemonEntity pokemon) async {
    // Fallback to original color scheme
    if (pokemon.images.medium == null) {
      return lightColorScheme;
    }

    try {
      final pokemonColorScheme = await ColorScheme.fromImageProvider(
          provider: NetworkImage(pokemon.images.medium!));

      return pokemonColorScheme;
    } catch (e) {
      // Fallback to original color scheme
      return lightColorScheme;
    }
  }
}
