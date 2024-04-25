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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
            // border: Border.all(color: context.onSurface.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              BackgroundIcon(icon: status.icon),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  status.label,
                  style: context.titleSmall,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: context.primaryContainer,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: Text(
                    status.value.toString(),
                    style: context.titleMedium.copyWith(
                      color: context.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundIcon extends StatelessWidget {
  const BackgroundIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: context.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            icon,
            color: context.primary,
            size: 18,
          ),
        ));
  }
}

class PokemonStatsTab extends StatelessWidget {
  const PokemonStatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: pokemonStore.pokemon.stats.length,
      itemBuilder: (context, index) =>
          _StatTile(status: pokemonStore.pokemon.stats[index]),
    );
  }
}
