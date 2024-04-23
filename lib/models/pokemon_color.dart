import 'package:flutter/material.dart';

// This class will have the color scheme based on the pokemon image
final class PokemonColor {
  const PokemonColor({required this.name, required this.colorScheme});

  PokemonColor setScheme(ColorScheme pokemonColorScheme) =>
      PokemonColor(name: name, colorScheme: pokemonColorScheme);

  final String name;
  final ColorScheme colorScheme;
}
