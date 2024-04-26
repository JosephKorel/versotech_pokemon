import 'package:flutter/material.dart';
import 'package:spider_chart/spider_chart.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class _StatsSpiderChart extends StatelessWidget {
  const _StatsSpiderChart();

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<SinglePokemonStore>();
    final values =
        pokemonStore.pokemon.stats.map((e) => e.value.toDouble()).toList();

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) => SpiderChart(
            data: values,
            colors: values.map((e) => context.primary).toList(),
            size: Size(constraints.maxWidth / 2, constraints.maxHeight / 2),
            labels: pokemonStore.pokemon.stats
                .map(
                  (e) => e.chartLabel,
                )
                .toList()),
      ),
    );
  }
}

class StatsTab extends StatelessWidget {
  const StatsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StatsSpiderChart();
  }
}
