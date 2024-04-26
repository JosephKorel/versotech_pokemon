import 'package:flutter/material.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/utils/navigation.dart';

class PokemonDetailsErrorScreen extends StatelessWidget {
  const PokemonDetailsErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Whoops!'),
          titleTextStyle: context.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 28,
            color: context.onSurface,
          ),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                errorMessage,
                style: context.bodyLarge
                    .copyWith(color: context.onSurface.withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: FilledButton.icon(
                  onPressed: context.pop,
                  icon: const Icon(Icons.arrow_back_ios),
                  label: const Text('Go Back'),
                ),
              ),
            ],
          ),
        ));
  }
}
