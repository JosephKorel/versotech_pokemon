// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_single_pokemon.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FetchSinglePokemonStore on _FetchSinglePokemonStoreBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_FetchSinglePokemonStoreBase.loading'))
      .value;
  Computed<PokemonEntity>? _$pokemonComputed;

  @override
  PokemonEntity get pokemon =>
      (_$pokemonComputed ??= Computed<PokemonEntity>(() => super.pokemon,
              name: '_FetchSinglePokemonStoreBase.pokemon'))
          .value;
  Computed<bool>? _$hasActivePokemonComputed;

  @override
  bool get hasActivePokemon => (_$hasActivePokemonComputed ??= Computed<bool>(
          () => super.hasActivePokemon,
          name: '_FetchSinglePokemonStoreBase.hasActivePokemon'))
      .value;

  late final _$stateAtom =
      Atom(name: '_FetchSinglePokemonStoreBase.state', context: context);

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

  late final _$fetchPokemonAsyncAction = AsyncAction(
      '_FetchSinglePokemonStoreBase.fetchPokemon',
      context: context);

  @override
  Future<void> fetchPokemon(String pokemonName) {
    return _$fetchPokemonAsyncAction.run(() => super.fetchPokemon(pokemonName));
  }

  late final _$_FetchSinglePokemonStoreBaseActionController =
      ActionController(name: '_FetchSinglePokemonStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_FetchSinglePokemonStoreBaseActionController
        .startAction(name: '_FetchSinglePokemonStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_FetchSinglePokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateState(SinglePokemonState newState) {
    final _$actionInfo = _$_FetchSinglePokemonStoreBaseActionController
        .startAction(name: '_FetchSinglePokemonStoreBase.updateState');
    try {
      return super.updateState(newState);
    } finally {
      _$_FetchSinglePokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_FetchSinglePokemonStoreBaseActionController
        .startAction(name: '_FetchSinglePokemonStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_FetchSinglePokemonStoreBaseActionController.endAction(_$actionInfo);
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
