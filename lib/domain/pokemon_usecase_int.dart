import 'package:versotech_pokemon/models/pokemon_abilities.dart';
import 'package:versotech_pokemon/models/pokemon_characteristics.dart';
import 'package:versotech_pokemon/models/pokemon_detail_state.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/pokemon_state.dart';
import 'package:versotech_pokemon/models/request_params.dart';
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

interface class PokemonUsecaseService {
  Future<SinglePokemonState> fetchSinglePokemon(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<PokemonListState> fetchPokemons(ApiRequestParams params) =>
      throw UnimplementedError();

  Future<PokemonCharacteristicsState> getCharacteristics(
    ApiRequestParams params,
  ) =>
      throw UnimplementedError();

  Future<PokemonAbilityState> getAbility(ApiRequestParams params) =>
      throw UnimplementedError();
}
