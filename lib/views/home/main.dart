import 'package:flutter/material.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_list.dart';
import 'package:versotech_pokemon/views/home/widgets/theme_mode.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versomon'),
        centerTitle: true,
        actions: const [ThemeSwitch()],
        backgroundColor: context.background,
        scrolledUnderElevation: 0,
      ),
      body: const PokemonListContainer(),
    );
  }
}
