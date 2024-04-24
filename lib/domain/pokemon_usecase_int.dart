import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';

// This class has all methods we need to deal with the pokemon feature
// i.e fetching a list, a specific pokemon, adding to favorite, etc
interface class PokemonUsecaseInterface {
  Future<List<SimplePokemon>> fetchPokemons(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<PokemonEntity> fetchSinglePokemon(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<Ability> getAbilityDescription(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<List<Characteristic>> getCharacteristic(ApiRequestParams params) =>
      throw UnimplementedError();
}
