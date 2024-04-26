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
        Icons.smartphone_rounded,
      ][index];
}

// This store will control the theme of the application
class ThemeStore = _ThemeStoreBase with _$ThemeStore;

abstract class _ThemeStoreBase with Store {
  final _themeLocalService = locator.get<ThemeLocalService>();

  ColorScheme _getSystemBrightness() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;

    return brightness == Brightness.dark ? darkColorScheme : lightColorScheme;
  }

  @observable
  ThemeOptions theme = ThemeOptions.system;

  @action
  void readTheme() => theme = _themeLocalService.getTheme();

  @action
  ThemeOptions setTheme(ThemeOptions newTheme) => theme = newTheme;

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

  // Everytime theme changes, save it in shared prefs
  void onThemeChange() {
    final _ = reaction((_) => theme, _themeLocalService.setTheme);
  }
}
