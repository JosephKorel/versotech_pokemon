// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_pokemons.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoadedPokemonStore on _LoadedPokemonStoreBase, Store {
  Computed<PokemonEntity>? _$currentPokemonComputed;

  @override
  PokemonEntity get currentPokemon => (_$currentPokemonComputed ??=
          Computed<PokemonEntity>(() => super.currentPokemon,
              name: '_LoadedPokemonStoreBase.currentPokemon'))
      .value;
  Computed<List<Ability>>? _$pokemonAbilitiesComputed;

  @override
  List<Ability> get pokemonAbilities => (_$pokemonAbilitiesComputed ??=
          Computed<List<Ability>>(() => super.pokemonAbilities,
              name: '_LoadedPokemonStoreBase.pokemonAbilities'))
      .value;

  late final _$pokemonsAtom =
      Atom(name: '_LoadedPokemonStoreBase.pokemons', context: context);

  @override
  ObservableList<PokemonEntity> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<PokemonEntity> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$_LoadedPokemonStoreBaseActionController =
      ActionController(name: '_LoadedPokemonStoreBase', context: context);

  @override
  void reset() {
    final _$actionInfo = _$_LoadedPokemonStoreBaseActionController.startAction(
        name: '_LoadedPokemonStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_LoadedPokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePokemonAbility({required Ability ability}) {
    final _$actionInfo = _$_LoadedPokemonStoreBaseActionController.startAction(
        name: '_LoadedPokemonStoreBase.updatePokemonAbility');
    try {
      return super.updatePokemonAbility(ability: ability);
    } finally {
      _$_LoadedPokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPokemon(PokemonEntity pokemon) {
    final _$actionInfo = _$_LoadedPokemonStoreBaseActionController.startAction(
        name: '_LoadedPokemonStoreBase.addPokemon');
    try {
      return super.addPokemon(pokemon);
    } finally {
      _$_LoadedPokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemons: ${pokemons},
currentPokemon: ${currentPokemon},
pokemonAbilities: ${pokemonAbilities}
    ''';
  }
}
