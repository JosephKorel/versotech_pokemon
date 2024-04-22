import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

final class PokemonUsecaseImplementation implements PokemonUsecaseInterface {
  const PokemonUsecaseImplementation(this._repository);

  final RepositoryInterface _repository;

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
  Future<List<SimplePokemonEntity>> fetchPokemons(
      ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);

      if (request == null) {
        throw Exception('Failed to get pokemon list');
      }

      return (request['results'] as List<dynamic>)
          .map((e) => SimplePokemonEntity.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
