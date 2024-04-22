import 'package:dio/dio.dart';
import 'package:versotech_pokemon/domain/pokemon_list_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/domain/single_pokemon_state.dart';

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

  Future<SinglePokemonState> fetchSinglePokemon(ApiRequestParams params) async {
    try {
      final pokemon = await _interface.fetchSinglePokemon(params);
      return LoadedPokemon(pokemon: pokemon);
    } on DioException catch (e) {
      return FailedToLoad(error: e.error, stackStrace: e.stackTrace);
    } catch (e) {
      return const FailedToLoad();
    }
  }
}
