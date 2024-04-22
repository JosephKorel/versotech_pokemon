import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

final class PokemonUsecaseImplementation implements PokemonUsecaseInterface {
  const PokemonUsecaseImplementation(this._repository);

  final RepositoryInterface _repository;

  List<ApiRequestParams> _getRequestForSinglePokemon(List<dynamic> results) {
    final requestList = <ApiRequestParams>[];
    for (final result in results) {
      final url = (result as Map<String, dynamic>)['url'];
      requestList.add(SinglePokemonRequest.fromUrl(url));
    }

    return requestList;
  }

  @override
  Future<PokemonEntity> fetchSinglePokemon(ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);

      if (request == null) {
        throw Exception('No pokemon found');
      }

      return PokemonEntity.fromJson(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PokemonEntity>> fetchPokemons(ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);

      if (request == null) {
        throw Exception('No pokemon found');
      }

      final pokemonsFuture =
          _getRequestForSinglePokemon(request['results'] as List<dynamic>)
              .map((e) => fetchSinglePokemon(e));

      final pokemons = await Future.wait(pokemonsFuture);

      return pokemons;
    } catch (e) {
      rethrow;
    }
  }
}
