import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class HalfCirclePainter extends CustomPainter {
  final pokemonDetailStore = locator.get<PokemonDetailsStore>();

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        pokemonDetailStore.colorScheme!.primary,
        pokemonDetailStore.colorScheme!.primary.withOpacity(0.6)
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Paint paint = Paint()
      ..color = pokemonDetailStore.colorScheme!.primary
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill
      ..shader = gradient;

    // Defina o raio do círculo
    double radius = size.width / 1.2;

    Offset center = Offset(size.width / 2, -16);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), 0, pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
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
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          CustomPaint(
            size: constraints.biggest,
            painter: HalfCirclePainter(),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CachedNetworkImage(
                imageUrl: pokemonStore.pokemon.images.medium ?? '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
