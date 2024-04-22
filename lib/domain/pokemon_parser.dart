import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

final class PokemonParser {
  static Future<List<PokemonEntity>> call(List<dynamic> results) async {
    try {
      final pokemonFutureList = <Future<Map<String, dynamic>>>[];
      for (final result in results) {
        final url = (result as Map<String, dynamic>)['url'];
        final request = SinglePokemonRequest.fromUrl(url);
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }
}
