import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/views/home/main.dart';

Future<void> main() async {
  setUpLocation();
  WidgetsFlutterBinding.ensureInitialized();

  // Setting up the app theme
/*   final themeStore = locator.get<ThemeStore>();

  final brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  themeStore.setBrightness(darkMode: brightness == Brightness.dark); */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final key = locator.get<GlobalKey<NavigatorState>>();
    final theme = locator.get<ThemeStore>();
    return MaterialApp(
      title: 'Versotech Pokemon',
      theme: ThemeData(
        colorScheme: theme.colorScheme,
        useMaterial3: true,
      ),
      navigatorKey: key,
      home: const HomeView(),
    );
  }
}
