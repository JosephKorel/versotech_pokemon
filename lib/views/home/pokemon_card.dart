import 'package:flutter/material.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        name,
        style: context.titleLarge,
      ),
    );
  }
}
