import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/error.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/app_bar.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/content.dart';
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
    _pokemon.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => switch (_pokemon.state) {
        LoadingPokemon() => const _LoadingScreen(),
        LoadedPokemon(pokemon: _) => const _PokemonMainScreen(),
        FailedToGetPokemon(error: final e) => _ErrorScreen(error: e)
      },
    );
  }
}

class _PokemonMainScreen extends StatelessWidget {
  const _PokemonMainScreen({super.key});

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

// TODO - loading screen
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// TODO - error screen
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({super.key, required this.error});

  final ApiException error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error.message),
      ),
    );
  }
}
