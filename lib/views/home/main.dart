import 'package:flutter/material.dart';
import 'package:versotech_pokemon/views/home/widgets/app_bar.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomePageAppBar(),
      body: PokemonListContainer(),
    );
  }
}
