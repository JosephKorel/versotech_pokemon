import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/color_schemes.g.dart';

mixin PokemonDetailsController {
  void getPokemonTheme(PokemonEntity pokemon) async {
    final pokemonDetailsStore = locator.get<PokemonDetailsStore>();

    // Fallback to original color scheme
    if (pokemon.images.medium == null) {
      pokemonDetailsStore.setColorScheme(lightColorScheme);

      return;
    }

    try {
      final pokemonColorScheme = await ColorScheme.fromImageProvider(
          provider: NetworkImage(pokemon.images.medium!));

      pokemonDetailsStore.setColorScheme(pokemonColorScheme);
    } catch (e) {
      // Fallback to original color scheme
      pokemonDetailsStore.setColorScheme(lightColorScheme);
    }
  }
}
