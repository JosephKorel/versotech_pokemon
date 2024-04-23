import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/utils/navigation.dart';

class PokemonDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PokemonDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();

    void onPressed() {
      context.pop();
    }

    return AppBar(
      title: Text(pokemonDetailStore.pokemon?.name.toUpperCase() ?? ''),
      leading: IconButton.outlined(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
