import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

part 'request_params.g.dart';

class PaginationStore = _PaginationStoreBase with _$PaginationStore;

abstract class _PaginationStoreBase with Store {
  @observable
  ApiPagination pagination = const ApiPagination();

  @computed
  ApiRequestParams get params => PokemonListRequest(pagination: pagination);

  //
}
