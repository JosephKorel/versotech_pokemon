import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_list_state.dart';

part 'request_params.g.dart';

class PaginationStore = _PaginationStoreBase with _$PaginationStore;

abstract class _PaginationStoreBase with Store {
  final _pokemonStateStore = locator.get<PokemonStateStore>();

  @observable
  ApiPagination pagination = const ApiPagination();
  late ReactionDisposer _dispose;

  @computed
  ApiRequestParams get params => PokemonListRequest(pagination: pagination);

  @action
  void nextPage() {
    pagination = pagination.nextPage;
  }

  void onPaginationChange() {
    // Set up onStateChange
    _pokemonStateStore.onStateChange();

    _dispose = autorun((_) {
      _pokemonStateStore
          .fetchPokemons(PokemonListRequest(pagination: pagination));
    });
  }
}
