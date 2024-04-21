import 'package:dio/dio.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

final class PokemonUsecase {
  const PokemonUsecase(this._interface);

  final PokemonUsecaseInterface _interface;

  Future<PokemonListState> fetchPokemons(ApiRequestParams params) async {
    try {
      final pokemons = await _interface.fetchPokemons(params);
      return FetchedPokemons(pokemons: pokemons);
    } on DioException catch (e) {
      return ErrorFetchingPokemons.fromDioException(e);
    } catch (e) {
      return const ErrorFetchingPokemons(message: 'An unknown error happened');
    }
  }
}
