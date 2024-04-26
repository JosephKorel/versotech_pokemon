import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';

class HalfCirclePainter extends CustomPainter {
  final pokemonColor = locator.get<ColorSchemesStore>();

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        pokemonColor.colorScheme.primary,
        pokemonColor.colorScheme.primary.withOpacity(0.6)
      ],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Paint paint = Paint()
      ..color = pokemonColor.colorScheme.primary
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill
      ..shader = gradient;

    // Defina o raio do círculo
    double radius = size.width / 1.6;

    Offset center = Offset(size.width / 2, -16);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), 0, pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PokemonProfile extends StatelessWidget {
  const PokemonProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<SinglePokemonStore>();

    return LayoutBuilder(
      builder: (context, constraints) => CustomPaint(
        size: constraints.biggest,
        painter: HalfCirclePainter(),
        child: CachedNetworkImage(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          fit: BoxFit.fitHeight,
          imageUrl: pokemonStore.pokemon.images.large ?? '',
        ),
      ),
    );
  }
}
