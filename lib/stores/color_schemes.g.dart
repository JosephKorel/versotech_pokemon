// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_schemes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ColorSchemesStore on _ColorSchemesStoreBase, Store {
  Computed<ColorScheme>? _$colorSchemeComputed;

  @override
  ColorScheme get colorScheme =>
      (_$colorSchemeComputed ??= Computed<ColorScheme>(() => super.colorScheme,
              name: '_ColorSchemesStoreBase.colorScheme'))
          .value;

  late final _$colorSchemesAtom =
      Atom(name: '_ColorSchemesStoreBase.colorSchemes', context: context);

  @override
  ObservableList<PokemonColor> get colorSchemes {
    _$colorSchemesAtom.reportRead();
    return super.colorSchemes;
  }

  @override
  set colorSchemes(ObservableList<PokemonColor> value) {
    _$colorSchemesAtom.reportWrite(value, super.colorSchemes, () {
      super.colorSchemes = value;
    });
  }

  late final _$getPokemonThemeAsyncAction =
      AsyncAction('_ColorSchemesStoreBase.getPokemonTheme', context: context);

  @override
  Future<void> getPokemonTheme(SimplePokemon pokemon) {
    return _$getPokemonThemeAsyncAction
        .run(() => super.getPokemonTheme(pokemon));
  }

  late final _$_ColorSchemesStoreBaseActionController =
      ActionController(name: '_ColorSchemesStoreBase', context: context);

  @override
  void addColor(PokemonColor color) {
    final _$actionInfo = _$_ColorSchemesStoreBaseActionController.startAction(
        name: '_ColorSchemesStoreBase.addColor');
    try {
      return super.addColor(color);
    } finally {
      _$_ColorSchemesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colorSchemes: ${colorSchemes},
colorScheme: ${colorScheme}
    ''';
  }
}
