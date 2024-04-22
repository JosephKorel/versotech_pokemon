import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

final class PokemonUsecaseImplementation implements PokemonUsecaseInterface {
  const PokemonUsecaseImplementation(this._repository);

  final RepositoryInterface _repository;

  List<Future<PokemonEntity>> _getRequestForSinglePokemon(
      List<dynamic> results) {
    final requestList = <Future<PokemonEntity>>[];
    for (final result in results) {
      final name = (result as Map<String, dynamic>)['name'];
      final params = SinglePokemonRequest.fromName(name);
      requestList.add(fetchSinglePokemon(params));
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
          _getRequestForSinglePokemon((request['results'] as List<dynamic>));

      final pokemons = await Future.wait(pokemonsFuture);

      return pokemons;
    } catch (e) {
      rethrow;
    }
  }
}
