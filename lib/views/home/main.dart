import 'package:flutter/material.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_list.dart';

/* void fetchIt() async {
  final pokemons = [
    'bulbasaur',
    'ivysaur',
    'venusaur',
    'charmander',
    'charmeleon',
    'charizard',
    'squirtle',
    'wartortle',
    'blastoise',
    'caterpie'
  ];

  final futures = pokemons.map((e) {
    final url = 'https://pokeapi.co/api/v2/pokemon/$e';
    return Dio().get(url);
  }).toList();

  final result = await Future.wait(futures);

  log('We are done');
} */

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PokemonListContainer(),
    );
  }
}
