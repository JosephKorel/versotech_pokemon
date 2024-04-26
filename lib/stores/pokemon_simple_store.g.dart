// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_simple_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonListStore on _PokemonStateBase, Store {
  Computed<int>? _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??=
          Computed<int>(() => super.length, name: '_PokemonStateBase.length'))
      .value;

  late final _$pokemonsAtom =
      Atom(name: '_PokemonStateBase.pokemons', context: context);

  @override
  ObservableList<SimplePokemon> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<SimplePokemon> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$_PokemonStateBaseActionController =
      ActionController(name: '_PokemonStateBase', context: context);

  @override
  void addPokemons(List<SimplePokemon> newPokemons) {
    final _$actionInfo = _$_PokemonStateBaseActionController.startAction(
      name: '_PokemonStateBase.addPokemons',
    );
    try {
      return super.addPokemons(newPokemons);
    } finally {
      _$_PokemonStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getSavedPokemons() {
    final _$actionInfo = _$_PokemonStateBaseActionController.startAction(
      name: '_PokemonStateBase.getSavedPokemons',
    );
    try {
      return super.getSavedPokemons();
    } finally {
      _$_PokemonStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_PokemonStateBaseActionController.startAction(
      name: '_PokemonStateBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$_PokemonStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
length: ${length}
    ''';
  }
}
