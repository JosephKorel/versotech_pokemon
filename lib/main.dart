import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/views/home/main.dart';

void main() {
  setUpLocation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final key = locator.get<GlobalKey<NavigatorState>>();
    return MaterialApp(
      title: 'Versotech Pokemon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: key,
      home: const HomeView(),
    );
  }
}
