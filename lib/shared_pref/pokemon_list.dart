import 'dart:developer';

import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/shared_pref/interface.dart';

final class PokemonListLocalService {
  static const _key = 'pokemonList';

  const PokemonListLocalService(this._localStorageService);

  final SharedPrefService _localStorageService;

  List<SimplePokemon> getPokemons() {
    final value = _localStorageService.getKey<List<dynamic>>(key: _key);

    if (value == null) {
      return [];
    }

    log('THE LENGTH OF SAVED POKEMONS IS: ${value.length}');

    return value
        .map((e) => SimplePokemon.fromLocalStorage(e as Map<String, dynamic>))
        .toList();
  }

  Future<bool> setPokemons(List<SimplePokemon> pokemons) async {
    try {
      final saved = await _localStorageService.setKey(
        key: _key,
        value: pokemons.map((e) => e.toJson()).toList(),
      );

      log('Successfully saved');

      return saved;
    } catch (e) {
      log('Error when saving');
      return false;
    }
  }
}
