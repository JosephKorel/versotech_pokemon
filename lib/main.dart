import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_state.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/views/home/main.dart';

Future<void> main() async {
  // So we can read the platform brightness in ThemeStore
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocation();

  final themeStore = locator.get<ThemeStore>();
  final pokemonListStore = locator.get<PokemonListStore>();
  final pokemonStateStore = locator.get<PokemonStateStore>();

  // Read the pokemons that are alreeady saved in the local storage
  pokemonListStore.getSavedPokemons();

  // Update the current state of pokemon store, otherwise it would stay in loading state forever
  pokemonStateStore
      .setPokemonState(FetchedPokemons(pokemons: pokemonListStore.pokemons));

  // Read current theme
  themeStore.readTheme();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final key = locator.get<GlobalKey<NavigatorState>>();
    final theme = locator.get<ThemeStore>();

    // Make it as an observer to watch changes in ThemeStore
    return Observer(
      builder: (context) => MaterialApp(
        title: 'Versotech Pokemon',
        navigatorKey: key,
        theme: ThemeData(
          colorScheme: theme.colorScheme,
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
