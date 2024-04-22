import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_store.dart';
import 'package:versotech_pokemon/views/home/pokemon_card.dart';

class PokemonListContainer extends StatelessWidget {
  const PokemonListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<PokemonListStore>();

    return Observer(
      builder: (context) => GridView.builder(
        itemCount: pokemonStore.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => PokemonCard(
          simplePokemon: pokemonStore.pokemons[index],
        ),
      ),
    );
  }
}
