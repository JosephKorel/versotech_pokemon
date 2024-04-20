import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

final class PokemonUsecaseImplementation implements PokemonUsecaseInterface {
  const PokemonUsecaseImplementation(this._repository);

  final RepositoryInterface _repository;

  @override
  Future<List<PokemonEntity>> fetchPokemons(ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);

      if (request == null) {
        throw Exception('No exception found');
      }

      final pokemons = (request['results'] as List<dynamic>)
          .map((e) => PokemonEntity.fromJson(e as Map<String, dynamic>))
          .toList();

      return pokemons;
    } catch (e) {
      rethrow;
    }
  }
}

final class PokemonUsecase {
  const PokemonUsecase(this._interface);

  final PokemonUsecaseInterface _interface;

  Future<PokemonListState> fetchPokemons(ApiRequestParams params) async {
    try {
      final pokemons = await _interface.fetchPokemons(params);
      return FetchedPokemons(pokemons: pokemons);
    } catch (e) {
      // TODO - Implement proper error handling
      return const ErrorFetchingPokemons(message: 'Could not fetch pokemons');
    }
  }
}
