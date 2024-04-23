import 'package:flutter/material.dart';

final class PokemonColor {
  const PokemonColor({required this.name, required this.colorScheme});

  PokemonColor setScheme(ColorScheme pokemonColorScheme) =>
      PokemonColor(name: name, colorScheme: pokemonColorScheme);

  final String name;
  final ColorScheme colorScheme;
}
