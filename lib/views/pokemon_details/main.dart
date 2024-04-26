import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';
import 'package:versotech_pokemon/utils/navigation.dart';
import 'package:versotech_pokemon/views/home/widgets/error_screen.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/app_bar.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/content.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/loading_screen.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/profile.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key});

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  final _pokemon = locator.get<SinglePokemonStore>();

  @override
  void dispose() {
    super.dispose();
    // Reset values to null when going back
    _pokemon.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => switch (_pokemon.state) {
        LoadingPokemon() => const PokemonDetailsLoadingScreen(),
        LoadedPokemon(pokemon: _) => const _PokemonMainScreen(),
        FailedToGetPokemon(error: final e) => ErrorView(
            message: e.message,
            actionButton: FilledButton.icon(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back_ios),
              label: const Text('Go Back'),
            ),
          ),
      },
    );
  }
}

class _PokemonMainScreen extends StatelessWidget {
  const _PokemonMainScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PokemonDetailsAppBar(),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(child: PokemonProfile()),
          Expanded(flex: 2, child: PokemonMainContent())
        ],
      ),
    );
  }
}
