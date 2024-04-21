// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStateStore on _PokemonStateStoreBase, Store {
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

  @override
  String toString() {
    return '''
pokemonState: ${pokemonState}
    ''';
  }
}
