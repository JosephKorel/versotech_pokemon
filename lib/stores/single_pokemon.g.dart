// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_pokemon.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SinglePokemonStore on _SinglePokemonStoreBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_SinglePokemonStoreBase.loading'))
      .value;
  Computed<PokemonEntity>? _$pokemonComputed;

  @override
  PokemonEntity get pokemon =>
      (_$pokemonComputed ??= Computed<PokemonEntity>(() => super.pokemon,
              name: '_SinglePokemonStoreBase.pokemon'))
          .value;
  Computed<bool>? _$hasActivePokemonComputed;

  @override
  bool get hasActivePokemon => (_$hasActivePokemonComputed ??= Computed<bool>(
          () => super.hasActivePokemon,
          name: '_SinglePokemonStoreBase.hasActivePokemon'))
      .value;

  late final _$stateAtom =
      Atom(name: '_SinglePokemonStoreBase.state', context: context);

  @override
  SinglePokemonState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SinglePokemonState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchPokemonAsyncAction =
      AsyncAction('_SinglePokemonStoreBase.fetchPokemon', context: context);

  @override
  Future<void> fetchPokemon(String pokemonName) {
    return _$fetchPokemonAsyncAction.run(() => super.fetchPokemon(pokemonName));
  }

  late final _$_SinglePokemonStoreBaseActionController =
      ActionController(name: '_SinglePokemonStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_SinglePokemonStoreBaseActionController.startAction(
        name: '_SinglePokemonStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_SinglePokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateState(SinglePokemonState newState) {
    final _$actionInfo = _$_SinglePokemonStoreBaseActionController.startAction(
        name: '_SinglePokemonStoreBase.updateState');
    try {
      return super.updateState(newState);
    } finally {
      _$_SinglePokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_SinglePokemonStoreBaseActionController.startAction(
        name: '_SinglePokemonStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_SinglePokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
loading: ${loading},
pokemon: ${pokemon},
hasActivePokemon: ${hasActivePokemon}
    ''';
  }
}
