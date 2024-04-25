import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/views/pokemon_details/controller/pokemon_cry.dart';

class _PokemonCryButton extends StatelessWidget with PokemonCryController {
  _PokemonCryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Play pokemon cry',
      onPressed: () => playAudio(context),
      icon: const Icon(Icons.multitrack_audio_rounded),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class PokemonDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const PokemonDetailsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final pokemonColorScheme = locator.get<ColorSchemesStore>();
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: pokemonColorScheme.colorScheme.onPrimary,
      elevation: 0,
      actions: [_PokemonCryButton()],
    );
  }
}
