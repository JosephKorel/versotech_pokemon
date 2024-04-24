import 'package:flutter/material.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  void onPressed(ThemeOptions theme) {}

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) => IconButton.outlined(
        onPressed: controller.open,
        icon: const Icon(Icons.more_horiz),
      ),
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
                  (states) => context.background,
                ),
              ),
              onPressed: () => onPressed(e),
              leadingIcon: Icon(e.icon),
              child: Text(e.label),
            ),
          )
          .toList(),
    );
  }
}
