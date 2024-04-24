import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/views/home/main.dart';

Future<void> main() async {
  setUpLocation();

  // So we can read the platform brightness in ThemeStore
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final key = locator.get<GlobalKey<NavigatorState>>();
    final theme = locator.get<ThemeStore>();

    // Make it as an observer to watch changes in ThemeStore
    return Observer(
      builder: (context) => MaterialApp(
        title: 'Versotech Pokemon',
        navigatorKey: key,
        theme: ThemeData(
          colorScheme: theme.colorScheme,
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
