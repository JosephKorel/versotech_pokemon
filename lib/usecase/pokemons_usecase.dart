import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

class PokemonUsecase {
  const PokemonUsecase(this._repository);

  final RepositoryInterface _repository;

  Future<PokemonListState> getPokemons(ApiRequestParams params) async {
    try {
      final pokemons = await _repository.get(params);
      if (pokemons == null) {
        throw Exception('No exception found');
      }

      // TODO - parse json list to pokemons

      return const FetchedPokemons(pokemons: []);
    } catch (e) {
      // TODO - treat errors
      return const ErrorFetchingPokemons(message: 'as');
    }
  }
}
