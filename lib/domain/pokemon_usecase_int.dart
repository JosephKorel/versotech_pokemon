import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

// This class has all methods we need to deal with the pokemon feature
// i.e fetching a list, a specific pokemon, adding to favorite, etc
interface class PokemonUsecaseInterface {
  Future<List<PokemonEntity>> fetchPokemons(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<PokemonEntity> fetchSinglePokemon(ApiRequestParams params) =>
      throw UnimplementedError();
}
