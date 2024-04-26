import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';

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
  Future<List<SimplePokemon>> fetchPokemons(ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);

      if (request == null) {
        throw Exception('No pokemon found');
      }

      final pokemons = (request['results'] as List<dynamic>)
          .map((e) => SimplePokemon.fromJson(e as Map<String, dynamic>))
          .toList();

      return pokemons;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Ability> getAbilityDescription(ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);
      if (request == null) {
        throw Exception('No ability found');
      }

      return Ability.fromAbilityJson(request);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Characteristic>> getCharacteristic(
      ApiRequestParams params) async {
    try {
      final request = await _repository.get(params);
      if (request == null) {
        throw Exception('No characteristic found');
      }

      final characteristics = <Characteristic>[];

      for (final item in request['flavor_text_entries'] as List<dynamic>) {
        if (item['language']['name'] != 'en') {
          continue;
        }
        final characteristic =
            Characteristic.fromJson(item as Map<String, dynamic>);
        if (characteristics.any(
            (element) => element.description == characteristic.description)) {
          continue;
        }

        characteristics.add(characteristic);
      }

      return characteristics;
    } catch (e) {
      rethrow;
    }
  }
}
