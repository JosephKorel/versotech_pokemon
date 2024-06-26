import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/tabs.dart';

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.type});

  final Type type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.primaryContainer,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          child: Text(
            type.type.toUpperCase(),
            style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600, color: context.onPrimaryContainer),
          ),
        ),
      ),
    );
  }
}

class _PokemonName extends StatelessWidget {
  const _PokemonName();

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<SinglePokemonStore>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              pokemonStore.pokemon.name.toUpperCase(),
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ).animate().fadeIn().slideHorizontal(),
            Text(
              pokemonStore.pokemon.idLabel,
              style: context.titleLarge.copyWith(
                  color: context.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w800),
            ).animate().fadeIn().slideHorizontal(),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: pokemonStore.pokemon.types
              .map((e) => _TypeBadge(type: e).animate().fadeEffect)
              .toList(),
        )
      ],
    );
  }
}

class PokemonMainContent extends StatelessWidget {
  const PokemonMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PokemonName(),
          Expanded(
            child: PokemonContentTabs(),
          )
        ],
      ),
    );
  }
}
