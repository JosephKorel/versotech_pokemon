import 'package:flutter/material.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/views/pokemon_details/widgets/app_bar.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PokemonDetailsAppBar(),
    );
  }
}
