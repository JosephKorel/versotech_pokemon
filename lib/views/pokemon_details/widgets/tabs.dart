import 'package:flutter/material.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/abilities.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/about.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/stats.dart';

enum Tabs {
  about,
  stats,
  abilities;

  Widget get widget => const [AboutTab(), StatsTab(), AbilitiesTab()][index];
}

class PokemonContentTabs extends StatefulWidget {
  const PokemonContentTabs({super.key});

  @override
  State<PokemonContentTabs> createState() => _PokemonContentTabsState();
}

class _PokemonContentTabsState extends State<PokemonContentTabs>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: Tabs.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _controller,
          tabs: Tabs.values
              .map((e) => Tab(
                    text: e.name.toUpperCase(),
                  ))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: Tabs.values.map((e) => e.widget).toList(),
          ),
        )
      ],
    );
  }
}
