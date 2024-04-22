import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final pokemonStoreState = locator.get<PokemonStateStore>();

    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: pokemonStoreState.loading
              ? context.onSurface.withOpacity(0.4)
              : context.onSurface),
      child: Text(
        name,
        style: context.titleLarge,
      ),
    );
  }
}
