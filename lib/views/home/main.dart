import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/views/home/widgets/app_bar.dart';
import 'package:versotech_pokemon/views/home/widgets/error_screen.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Stores
  final _pokemonList = locator.get<PokemonListStore>();
  final _pokemonStateStore = locator.get<PokemonStateStore>();
  final _fetchSinglePokemonStore = locator.get<SinglePokemonStore>();
  final _paginationStore = locator.get<PaginationStore>();
  final _themeStore = locator.get<ThemeStore>();
  //

  @override
  void initState() {
    super.initState();

    _pokemonList.onStateChange();

    // Initiate reactions for theme store
    _themeStore.onThemeChange();

    // Make first request to fetch pokemons
    _paginationStore.onPaginationChange();

    // Start single pokemon store
    _fetchSinglePokemonStore.onStateChange();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) =>
          _pokemonList.pokemons.isEmpty && _pokemonStateStore.hasError
              ? HomeErrorScreen(
                  errorMessage: _pokemonStateStore.error.error.message)
              : const Scaffold(
                  appBar: HomePageAppBar(),
                  body: PokemonListContainer(),
                ),
    );
  }
}
