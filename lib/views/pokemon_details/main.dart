import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/app_bar.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/content.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  final _pokemonDetailsStore = locator.get<PokemonDetailsStore>();

  @override
  void dispose() {
    super.dispose();

    // Reset values to null when going back
    _pokemonDetailsStore.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      // Load color scheme based on pokemon colors
      builder: (context) => _pokemonDetailsStore.colorScheme == null
          ?
          // TODO - loading screen
          const Scaffold()
          : const PokemonMainScreen(),
    );
  }
}

class PokemonMainScreen extends StatelessWidget {
  const PokemonMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PokemonDetailsAppBar(),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          /* Expanded(child: PokemonProfile()), */
          Expanded(flex: 2, child: PokemonMainContent())
        ],
      ),
    );
  }
}
