// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonDetailsStore on _PokemonDetailsStoreBase, Store {
  Computed<bool>? _$loadingColorSchemeComputed;

  @override
  bool get loadingColorScheme => (_$loadingColorSchemeComputed ??=
          Computed<bool>(() => super.loadingColorScheme,
              name: '_PokemonDetailsStoreBase.loadingColorScheme'))
      .value;
  Computed<PokemonEntity?>? _$currentPokemonComputed;

  @override
  PokemonEntity? get currentPokemon => (_$currentPokemonComputed ??=
          Computed<PokemonEntity?>(() => super.currentPokemon,
              name: '_PokemonDetailsStoreBase.currentPokemon'))
      .value;
  Computed<String>? _$currentPokemonNameComputed;

  @override
  String get currentPokemonName => (_$currentPokemonNameComputed ??=
          Computed<String>(() => super.currentPokemonName,
              name: '_PokemonDetailsStoreBase.currentPokemonName'))
      .value;

  late final _$pokemonAtom =
      Atom(name: '_PokemonDetailsStoreBase.pokemon', context: context);

  @override
  SimplePokemon? get pokemon {
    _$pokemonAtom.reportRead();
    return super.pokemon;
  }

  @override
  set pokemon(SimplePokemon? value) {
    _$pokemonAtom.reportWrite(value, super.pokemon, () {
      super.pokemon = value;
    });
  }

  late final _$colorSchemeAtom =
      Atom(name: '_PokemonDetailsStoreBase.colorScheme', context: context);

  @override
  ColorScheme? get colorScheme {
    _$colorSchemeAtom.reportRead();
    return super.colorScheme;
  }

  @override
  set colorScheme(ColorScheme? value) {
    _$colorSchemeAtom.reportWrite(value, super.colorScheme, () {
      super.colorScheme = value;
    });
  }

  late final _$_PokemonDetailsStoreBaseActionController =
      ActionController(name: '_PokemonDetailsStoreBase', context: context);

  @override
  void setColorScheme(ColorScheme pokemonColorScheme) {
    final _$actionInfo = _$_PokemonDetailsStoreBaseActionController.startAction(
        name: '_PokemonDetailsStoreBase.setColorScheme');
    try {
      return super.setColorScheme(pokemonColorScheme);
    } finally {
      _$_PokemonDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPokemon(SimplePokemon selectedPokemon) {
    final _$actionInfo = _$_PokemonDetailsStoreBaseActionController.startAction(
        name: '_PokemonDetailsStoreBase.setPokemon');
    try {
      return super.setPokemon(selectedPokemon);
    } finally {
      _$_PokemonDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_PokemonDetailsStoreBaseActionController.startAction(
        name: '_PokemonDetailsStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_PokemonDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemon: ${pokemon},
colorScheme: ${colorScheme},
loadingColorScheme: ${loadingColorScheme},
currentPokemon: ${currentPokemon},
currentPokemonName: ${currentPokemonName}
    ''';
  }
}
