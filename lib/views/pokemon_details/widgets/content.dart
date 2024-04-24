import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/tabs.dart';

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({super.key, required this.type});

  final Type type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
            // border: Border.all(color: context.primary),
            color: context.primaryContainer,
            borderRadius: BorderRadius.circular(32)),
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
  const _PokemonName({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

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
            ),
            Text(
              pokemonStore.pokemon.idLabel,
              style: context.titleLarge.copyWith(
                  color: context.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: pokemonStore.pokemon.types
              .map((e) => _TypeBadge(type: e))
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
