import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_list_state.dart';
import 'package:versotech_pokemon/stores/pokemon_store.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/views/home/pokemon_card.dart';

class PokemonListContainer extends StatefulWidget {
  const PokemonListContainer({super.key});

  @override
  State<PokemonListContainer> createState() => _PokemonListContainerState();
}

class _PokemonListContainerState extends State<PokemonListContainer> {
  final _pokemonStoreState = locator.get<PokemonStateStore>();
  final _paginationStore = locator.get<PaginationStore>();
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // Make first request to fetch pokemons
    _paginationStore.onPaginationChange();

    _controller.addListener(() {
      final reachedEnd = _controller.position.atEdge && _controller.offset != 0;

      // Fetch more pokemons when reached the end
      // Also check if it's not fetching pokemons already
      if (_controller.hasClients && reachedEnd && !_pokemonStoreState.loading) {
        _paginationStore.nextPage();
      }
    });
  }

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
