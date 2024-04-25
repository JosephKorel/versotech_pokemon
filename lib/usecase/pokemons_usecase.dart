import 'package:dio/dio.dart';
import 'package:versotech_pokemon/domain/pokemon_abilities.dart';
import 'package:versotech_pokemon/domain/pokemon_characteristics.dart';
import 'package:versotech_pokemon/domain/pokemon_detail_state.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/error.dart';

final class PokemonUsecase implements PokemonUsecaseService {
  const PokemonUsecase(this._interface);

  final PokemonUsecaseInterface _interface;

  @override
  Future<SinglePokemonState> fetchSinglePokemon(ApiRequestParams params) async {
    try {
      final pokemon = await _interface.fetchSinglePokemon(params);
      return LoadedPokemon(pokemon: pokemon);
    } on DioException catch (e) {
      return FailedToGetPokemon(error: ApiException.fromDioException(e));
    } catch (e) {
      return const FailedToGetPokemon(
        error: ApiException(message: 'Failed to get pokemon data'),
      );
    }
  }

  @override
  Future<PokemonListState> fetchPokemons(ApiRequestParams params) async {
    try {
      final pokemons = await _interface.fetchPokemons(params);
      return FetchedPokemons(pokemons: pokemons);
    } on DioException catch (e) {
      return ErrorFetchingPokemons(error: ApiException.fromDioException(e));
    } catch (e) {
      return const ErrorFetchingPokemons(
        error: ApiException(
            message: 'An unknown error happened while getting pokemons list'),
      );
    }
  }

  @override
  Future<PokemonCharacteristicsState> getCharacteristics(
      ApiRequestParams params) async {
    try {
      final characteristics = await _interface.getCharacteristic(params);
      return LoadedCharacteristics(characteristics: characteristics);
    } on DioException catch (e) {
      return FailedToGetCharacteristics(
          error: ApiException.fromDioException(e));
    } catch (e) {
      return const FailedToGetCharacteristics(
        error: ApiException(message: 'Failed to get pokemon characteristic'),
      );
    }
  }

  @override
  Future<PokemonAbilityState> getAbility(ApiRequestParams params) async {
    try {
      final ability = await _interface.getAbilityDescription(params);
      return LoadedAbility(ability: ability);
    } on DioException catch (e) {
      return FailedToGetAbility(error: ApiException.fromDioException(e));
    } catch (e) {
      return const FailedToGetAbility(
        error: ApiException(message: 'Failed to get pokemon ability'),
      );
    }
  }
}
