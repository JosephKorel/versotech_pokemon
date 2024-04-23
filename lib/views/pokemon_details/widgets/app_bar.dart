import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/utils/navigation.dart';

class PokemonDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PokemonDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<ColorSchemesStore>();

    void onPressed() {
      context.pop();
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back),
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          foregroundColor: pokemonDetailStore.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
