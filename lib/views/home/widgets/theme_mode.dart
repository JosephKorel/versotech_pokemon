import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = locator.get<ThemeStore>();

    void onPressed(ThemeOptions theme) {
      themeStore.setTheme(theme);
    }

    return Observer(
      builder: (context) => MenuAnchor(
        builder: (context, controller, child) => IconButton.outlined(
          onPressed: controller.open,
          icon: Icon(themeStore.icon),
          style: IconButton.styleFrom(
            foregroundColor: context.isDarkMode
                ? context.onPrimaryContainer
                : context.onPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide(
              color: context.isDarkMode
                  ? context.onPrimaryContainer
                  : context.onPrimary,
            ),
          ),
        ).animate().fadeIn().slideHorizontal(fromRight: true),
        style: MenuStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => context.background,
          ),
          surfaceTintColor: MaterialStateProperty.resolveWith(
            (states) => context.background,
          ),
        ),
        menuChildren: ThemeOptions.values
            .map(
              (e) => MenuItemButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => themeStore.theme == e
                        ? context.onSurface.withOpacity(0.1)
                        : context.background,
                  ),
                ),
                onPressed: () => onPressed(e),
                leadingIcon: Icon(
                  e.icon,
                  color: context.onSurface,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(e.label),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
