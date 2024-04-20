import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

interface class PokemonUsecaseInterface {
  Future<List<PokemonEntity>> fetchPokemons(ApiRequestParams params) =>
      throw UnimplementedError();
}
