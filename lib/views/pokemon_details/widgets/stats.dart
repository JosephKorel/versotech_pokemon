import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class _StatTile extends StatelessWidget {
  const _StatTile({super.key, required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            status.name.toUpperCase(),
            style: context.titleMedium,
          ),
        ),
        Icon(status.icon),
        const SizedBox(
          width: 8,
        ),
        Text(
          status.value.toString(),
          style: context.titleMedium.copyWith(
            color: context.onSurface.withOpacity(0.7),
          ),
        )
      ],
    );
  }
}

class PokemonStatsTab extends StatelessWidget {
  const PokemonStatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: pokemonStore.pokemon.stats.length,
      itemBuilder: (context, index) =>
          _StatTile(status: pokemonStore.pokemon.stats[index]),
    );
  }
}
