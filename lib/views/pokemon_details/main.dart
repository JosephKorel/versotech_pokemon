import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/views/pokemon_details/controller/theme.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/app_bar.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView>
    with PokemonDetailsController {
  final pokemonDetailsStore = locator.get<PokemonDetailsStore>();

  @override
  void initState() {
    super.initState();
    getPokemonTheme(widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    if (pokemonDetailsStore.colorScheme == null) {
      // TODO - make loading screen
      return const Scaffold();
    }

    return const Scaffold(
      appBar: PokemonDetailsAppBar(),
    );
  }
}
