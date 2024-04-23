import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class _ImageBackground extends StatelessWidget {
  const _ImageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();

    return Container(
      width: context.deviceWidth * 2,
      decoration: BoxDecoration(
        color: pokemonDetailStore.colorScheme!.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}

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
        border: Border.all(color: context.onSurface.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: context.onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
            blurRadius: 1,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Icon(
              status.icon,
              size: 12,
              color: pokemonDetailStore.colorScheme!.primary,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              status.value.toString(),
              style: context.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
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
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              const _ImageBackground(),
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
              Positioned(
                bottom: constraints.maxHeight * .2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemonDetailStore.pokemon!.stats
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: _PokemonStatBadge(status: e),
                            ))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
