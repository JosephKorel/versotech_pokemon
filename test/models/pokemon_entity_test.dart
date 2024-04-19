import 'package:flutter_test/flutter_test.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

import 'api_models.dart';

void main() {
  test('Should return PokemonEntity from api json', () {
    final pokemon = PokemonEntity.fromJson(pokemonExample);

    expect(pokemon, isA<PokemonEntity>());
  });
}
