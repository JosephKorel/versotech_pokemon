import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/shared_pref/theme.dart';
import 'package:versotech_pokemon/theme/color_schemes.g.dart';

part 'theme.g.dart';

enum ThemeOptions {
  light('Light'),
  dark('Dark'),
  system('System');

  const ThemeOptions(this.label);
  final String label;

  IconData get icon => [
        Icons.light_mode_rounded,
        Icons.dark_mode_rounded,
        Icons.smartphone_rounded
      ][index];
}

class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  final _key = locator.get<GlobalKey<NavigatorState>>();
  final _themeLocalService = locator.get<ThemeLocalService>();
  late final ReactionDisposer _dispose;

  ColorScheme _getSystemBrightness() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return brightness == Brightness.dark ? darkColorScheme : lightColorScheme;
  }

  @observable
  ThemeOptions theme = ThemeOptions.system;

  @action
  void readTheme() {
    final sharedPrefTheme = _themeLocalService.getTheme();
    log('This is our theme: ${sharedPrefTheme.name}');

    theme = sharedPrefTheme;
  }

  @action
  void setBrightness({required bool darkMode}) =>
      theme = darkMode ? ThemeOptions.dark : ThemeOptions.light;

  @action
  setTheme(ThemeOptions newTheme) => theme = newTheme;

  @computed
  ColorScheme get colorScheme => switch (theme) {
        ThemeOptions.light => lightColorScheme,
        ThemeOptions.dark => darkColorScheme,
        ThemeOptions.system => _getSystemBrightness()
      };

  @computed
  IconData get icon => colorScheme == lightColorScheme
      ? ThemeOptions.light.icon
      : ThemeOptions.dark.icon;

  void onThemeChange() {
    _dispose = reaction((_) => theme, (t) {
      _themeLocalService.setTheme(t);
    });
  }
}
