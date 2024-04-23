import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

part 'pokemon_details.g.dart';

// The purpose of this store is to hold the pokemon being viewed
// so we won't have to pass the same pokemon props down the widget tree
class PokemonDetailsStore = _PokemonDetailsStoreBase with _$PokemonDetailsStore;

abstract class _PokemonDetailsStoreBase with Store {
  @observable
  PokemonEntity? pokemon;

  @observable
  ColorScheme? colorScheme;

  @action
  void setColorScheme(ColorScheme pokemonColorScheme) =>
      colorScheme = pokemonColorScheme;

  @action
  void setPokemon(PokemonEntity selectedPokemon) => pokemon = selectedPokemon;
}
