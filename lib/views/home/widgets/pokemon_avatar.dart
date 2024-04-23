import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class PokemonAvatar extends StatefulWidget {
  const PokemonAvatar({super.key, required this.pokemon});

  final SimplePokemon pokemon;

  @override
  State<PokemonAvatar> createState() => PokemonAvatarState();
}

class PokemonAvatarState extends State<PokemonAvatar> {
  final _colorSchemeStore = locator.get<ColorSchemesStore>();

  @override
  void initState() {
    super.initState();
    _colorSchemeStore.getPokemonTheme(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    print('This is the length: ${_colorSchemeStore.colorSchemes.length}');
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.background,
            border: Border.all(color: context.onSurface.withOpacity(0.8)),
          ),
          child: const SizedBox.expand(),
        ),
      ),
      SizedBox.expand(
        child: CachedNetworkImage(
          imageUrl: widget.pokemon.imageUrl,
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
        ),
      ),
    ]);
  }
}
