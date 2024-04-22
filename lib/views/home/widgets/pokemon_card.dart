import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class _PokemonAvatar extends StatelessWidget {
  const _PokemonAvatar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
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
          imageUrl: url,
        ),
      ),
    ]);
  }
}

class _Name extends StatelessWidget {
  const _Name({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.onSurface.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(8),
        color: context.background,
        boxShadow: [
          BoxShadow(
            color: context.onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 2),
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          name,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.background,
        // border: Border.all(color: context.onSurface.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: context.onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 2),
            blurRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            _PokemonAvatar(
              url: pokemon.images.medium ?? '',
              // url: pokemon.images.gif ?? (pokemon.images.medium ?? ''),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _Name(name: pokemon.name.toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}
