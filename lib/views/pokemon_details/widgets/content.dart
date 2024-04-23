import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/tabs.dart';

class _PokemonName extends StatelessWidget {
  const _PokemonName({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          pokemonDetailStore.pokemon!.name.toUpperCase(),
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          pokemonDetailStore.pokemon!.idLabel,
          style: context.titleLarge.copyWith(
              color: context.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class PokemonMainContent extends StatelessWidget {
  const PokemonMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
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
