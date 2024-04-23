import 'package:flutter_test/flutter_test.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';

import 'api_models.dart';

void main() {
  test('Should return SimplePokemon from json', () {
    const bulbasaurImageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png';

    final pokemon = SimplePokemon.fromJson(pokemonFromListJson);

    expect(pokemon, isA<SimplePokemon>());
    expect(pokemon.imageUrl, bulbasaurImageUrl);
  });
}
