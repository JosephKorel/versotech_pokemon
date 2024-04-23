import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/theme/color_schemes.g.dart';

part 'pokemon_details.g.dart';

// The purpose of this store is to hold the pokemon being viewed
// so we won't have to pass the same pokemon props down the widget tree
class PokemonDetailsStore = _PokemonDetailsStoreBase with _$PokemonDetailsStore;

abstract class _PokemonDetailsStoreBase with Store {
  final _loadedPokemonsStore = locator.get<LoadedPokemonStore>();
  late final ReactionDisposer _dispose;

  @observable
  SimplePokemon? pokemon;

  @observable
  ColorScheme? colorScheme;

  @action
  void setColorScheme(ColorScheme pokemonColorScheme) =>
      colorScheme = pokemonColorScheme;

  @action
  void setPokemon(SimplePokemon selectedPokemon) => pokemon = selectedPokemon;

  @action
  void clear() {
    pokemon = null;
    colorScheme = null;
  }

  @computed
  bool get loadingColorScheme => colorScheme == null;

  @computed
  PokemonEntity? get currentPokemon => _viewingPokemon(pokemon!.name);

  @computed
  String get currentPokemonName => pokemon!.name;

  void onStateChange() {
    _dispose = reaction((p0) => pokemon, (pok) async {
      if (pokemon == null) {
        return;
      }

      final pokemonColorScheme = await _getPokemonTheme(pok!.imageUrl);
      setColorScheme(pokemonColorScheme);
    });
  }

  Future<ColorScheme> _getPokemonTheme(String url) async {
    try {
      final pokemonColorScheme =
          await ColorScheme.fromImageProvider(provider: NetworkImage(url));

      return pokemonColorScheme;
    } catch (e) {
      // Fallback to original color scheme
      return lightColorScheme;
    }
  }

  PokemonEntity? _viewingPokemon(String name) {
    PokemonEntity? foundPokemon;
    for (final pokemon in _loadedPokemonsStore.pokemons) {
      if (pokemon.name == name) {
        foundPokemon = pokemon;
      }
    }
    return foundPokemon;
  }
}
