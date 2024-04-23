import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';

class PokemonDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PokemonDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();

    return AppBar(
      title: Text(pokemonDetailStore.pokemon!.name.toUpperCase()),
    );
  }
}