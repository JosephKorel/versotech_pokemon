import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';

part 'request_params.g.dart';

// This store holds the current pagination of pokemons. When user scrolls down
// and reach bottom, it will update the store state, which will make PokemonStateStore
// react to it and fetch more pokemons
class PaginationStore = _PaginationStoreBase with _$PaginationStore;

abstract class _PaginationStoreBase with Store {
  final _pokemonStateStore = locator.get<PokemonStateStore>();
  final _pokemonListStore = locator.get<PokemonListStore>();
  late ReactionDisposer _dispose;

  @observable
  PokemonListRequest params =
      const PokemonListRequest(pagination: ApiPagination());

  @action
  void nextPage() {
    // The new offset will always be the current length of pokemons,
    // since we query the list as offset + limit
    params = params.nextPage(_pokemonListStore.length);
  }

  @action
  void reset() =>
      params = const PokemonListRequest(pagination: ApiPagination());

  @computed
  ApiPagination get pagination => params.pagination;

  // Used for testing only
  void onTestCalled() {
    final mockState = FetchedPokemons(
        pokemons: List.generate(3, (index) => SimplePokemon.mock()));

    _pokemonStateStore.onStateChange();

    _dispose = reaction((p0) => params, (_) {
      _pokemonStateStore.setPokemonState(mockState);
    });
  }

  void onPaginationChange() {
    // Set up onStateChange to make PokemonStateStore
    // listen to all changes of this store
    _pokemonStateStore.onStateChange();

    _dispose = autorun((_) {
      // If list is empty, should fetch new pokemons.
      // If it's not empty when the app starts, it means that there is already saved pokemons,
      // so it should not fetch initial pokemons. When user reaches end of the list
      // The new offset will be the same length as the pokemon list, which will
      // satisfy pagination.offset >= _pokemonListStore.length
      final shouldFetchNewPokemons = _pokemonListStore.length == 0 ||
          pagination.offset >= _pokemonListStore.length;

      if (shouldFetchNewPokemons) {
        // When the store has a new value, it will trigger a new request to fetch pokemons
        _pokemonStateStore.fetchPokemons(params);
      }
    });
  }
}
