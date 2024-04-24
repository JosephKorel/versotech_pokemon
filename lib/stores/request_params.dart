import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';

part 'request_params.g.dart';

class PaginationStore = _PaginationStoreBase with _$PaginationStore;

abstract class _PaginationStoreBase with Store {
  final _pokemonStateStore = locator.get<PokemonStateStore>();
  late ReactionDisposer _dispose;

  @observable
  ApiPagination pagination = const ApiPagination();

  @computed
  ApiRequestParams get params => PokemonListRequest(pagination: pagination);

  @action
  void nextPage() {
    pagination = pagination.nextPage;
  }

  void onPaginationChange() {
    // Set up onStateChange, thus making PokemonStateStore
    // listen all changes of this store
    _pokemonStateStore.onStateChange();

/*     _dispose = reaction((state) => state, (newState) {
      // When the store has a new value, it will trigger a new request to fetch pokemons
      _pokemonStateStore.fetchPokemons(params);
    }); */

    _dispose = autorun((_) {
      // When the store has a new value, it will trigger a new request to fetch pokemons
      _pokemonStateStore.fetchPokemons(params);
    });
  }
}
