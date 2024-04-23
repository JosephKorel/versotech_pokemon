import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class _PokemonStatBadge extends StatelessWidget {
  const _PokemonStatBadge({super.key, required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status.name),
    );
  }
}

class PokemonProfile extends StatelessWidget {
  const PokemonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();
    return SizedBox(
      height: context.deviceHeight / 3,
      width: double.infinity,
      child: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: pokemonDetailStore.colorScheme!.primary,
            ),
            child: const SizedBox.expand(),
          ),
          CachedNetworkImage(
            imageUrl: pokemonDetailStore.pokemon!.images.medium ?? '',
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: pokemonDetailStore.pokemon!.stats
                  .map((e) => _PokemonStatBadge(status: e))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
