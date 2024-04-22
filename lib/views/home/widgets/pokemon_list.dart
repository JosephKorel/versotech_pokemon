import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/pokemon_store.dart';
import 'package:versotech_pokemon/views/home/widgets/loading_card.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_card.dart';

class PokemonListContainer extends StatelessWidget {
  const PokemonListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStoreState = locator.get<PokemonStateStore>();
    final pokemonList = locator.get<PokemonListStore>();

    return Observer(
      builder: (context) => GridView.builder(
        itemCount: pokemonList.length + (pokemonStoreState.loading ? 6 : 0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => index >= pokemonList.length
            ? const LoadingCard()
            : PokemonCard(name: pokemonList.pokemons[index].name),
      ),
    );
  }
}
