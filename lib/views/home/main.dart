import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/views/home/pokemon_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _paginationStore = locator.get<PaginationStore>();

  @override
  void initState() {
    super.initState();
    _paginationStore.onPaginationChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const PokemonListContainer(),
    );
  }
}
