import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/home/widgets/theme_mode.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Versomon').animate().slideHorizontal(),
      titleTextStyle: context.titleLarge.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: 28,
        color:
            context.isDarkMode ? context.onPrimaryContainer : context.onPrimary,
      ),
      actions: const [ThemeSwitch()],
      elevation: 0,
      backgroundColor:
          context.isDarkMode ? context.primaryContainer : context.primary,
    );
  }
}
