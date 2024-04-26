// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStoreBase, Store {
  Computed<ColorScheme>? _$colorSchemeComputed;

  @override
  ColorScheme get colorScheme =>
      (_$colorSchemeComputed ??= Computed<ColorScheme>(() => super.colorScheme,
              name: '_ThemeStoreBase.colorScheme'))
          .value;
  Computed<IconData>? _$iconComputed;

  @override
  IconData get icon => (_$iconComputed ??=
          Computed<IconData>(() => super.icon, name: '_ThemeStoreBase.icon'))
      .value;

  late final _$themeAtom =
      Atom(name: '_ThemeStoreBase.theme', context: context);

  @override
  ThemeOptions get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeOptions value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$_ThemeStoreBaseActionController =
      ActionController(name: '_ThemeStoreBase', context: context);

  @override
  void readTheme() {
    final _$actionInfo = _$_ThemeStoreBaseActionController.startAction(
        name: '_ThemeStoreBase.readTheme');
    try {
      return super.readTheme();
    } finally {
      _$_ThemeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ThemeOptions setTheme(ThemeOptions newTheme) {
    final _$actionInfo = _$_ThemeStoreBaseActionController.startAction(
        name: '_ThemeStoreBase.setTheme');
    try {
      return super.setTheme(newTheme);
    } finally {
      _$_ThemeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
theme: ${theme},
colorScheme: ${colorScheme},
icon: ${icon}
    ''';
  }
}
