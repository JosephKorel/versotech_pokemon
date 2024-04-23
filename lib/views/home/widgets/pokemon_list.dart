import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/views/home/widgets/loading_card.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_card.dart';

class PokemonListContainer extends StatefulWidget {
  const PokemonListContainer({super.key});

  @override
  State<PokemonListContainer> createState() => _PokemonListContainerState();
}

class _PokemonListContainerState extends State<PokemonListContainer> {
  final _pokemonStoreState = locator.get<PokemonStateStore>();
  final _fetchSinglePokemonStore = locator.get<FetchSinglePokemonStore>();
  final _paginationStore = locator.get<PaginationStore>();
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // Make first request to fetch pokemons
    _paginationStore.onPaginationChange();

    // Start single pokemon store
    _fetchSinglePokemonStore.onStateChange();

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
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = locator.get<PokemonListStore>();

    return Observer(
      builder: (context) => GridView.builder(
        controller: _controller,
        itemCount: pokemonList.length + (_pokemonStoreState.loading ? 10 : 0),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => index >= pokemonList.length
            ? const LoadingCard()
            : PokemonCard(
                pokemon: pokemonList.pokemons[index],
              ),
      ),
    );
  }
}

// Explanation about GridView item count:
// If loading is true, add 10 items to the list and show
// a loading widget. Showing a different widget if pokemonStateStore was loading 
// would hide the already loaded pokemons. 