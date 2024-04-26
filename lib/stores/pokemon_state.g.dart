// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStateStore on _PokemonStateStoreBase, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(
        () => super.loading,
        name: '_PokemonStateStoreBase.loading',
      ))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
        () => super.hasError,
        name: '_PokemonStateStoreBase.hasError',
      ))
          .value;
  Computed<ErrorFetchingPokemons>? _$errorComputed;

  @override
  ErrorFetchingPokemons get error =>
      (_$errorComputed ??= Computed<ErrorFetchingPokemons>(
        () => super.error,
        name: '_PokemonStateStoreBase.error',
      ))
          .value;

  late final _$pokemonStateAtom =
      Atom(name: '_PokemonStateStoreBase.pokemonState', context: context);

  @override
  PokemonListState get pokemonState {
    _$pokemonStateAtom.reportRead();
    return super.pokemonState;
  }

  @override
  set pokemonState(PokemonListState value) {
    _$pokemonStateAtom.reportWrite(value, super.pokemonState, () {
      super.pokemonState = value;
    });
  }

  late final _$fetchPokemonsAsyncAction =
      AsyncAction('_PokemonStateStoreBase.fetchPokemons', context: context);

  @override
  Future<void> fetchPokemons(ApiRequestParams params) {
    return _$fetchPokemonsAsyncAction.run(() => super.fetchPokemons(params));
  }

  late final _$_PokemonStateStoreBaseActionController =
      ActionController(name: '_PokemonStateStoreBase', context: context);

  @override
  void setPokemonState(PokemonListState newState) {
    final _$actionInfo = _$_PokemonStateStoreBaseActionController.startAction(
      name: '_PokemonStateStoreBase.setPokemonState',
    );
    try {
      return super.setPokemonState(newState);
    } finally {
      _$_PokemonStateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_PokemonStateStoreBaseActionController.startAction(
      name: '_PokemonStateStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$_PokemonStateStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemonState: ${pokemonState},
loading: ${loading},
hasError: ${hasError},
error: ${error}
    ''';
  }
}
