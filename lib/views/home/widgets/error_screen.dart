import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(
      {super.key, required this.message, required this.actionButton});

  final String message;
  final Widget actionButton;

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
              Expanded(
                child: const Image(
                  image: AssetImage('assets/sad_pikachu.png'),
                  fit: BoxFit.cover,
                )
                    .animate(
                      onComplete: (controller) =>
                          controller.repeat(reverse: true),
                    )
                    .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: 1.seconds),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Text(
                      message,
                      style: context.bodyLarge
                          .copyWith(color: context.onSurface.withOpacity(0.8)),
                      textAlign: TextAlign.center,
                    ).animate().fadeIn().slideVertical(),
                    const SizedBox(
                      height: 16,
                    ),
                    actionButton
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class HomeErrorScreen extends StatelessWidget {
  const HomeErrorScreen({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final pokemonStoreState = locator.get<PokemonStateStore>();
    final paginationStore = locator.get<PaginationStore>();

    void onPressed() {
      pokemonStoreState.fetchPokemons(paginationStore.params);
    }

    return ErrorView(
      message: errorMessage,
      actionButton: FilledButton.icon(
        onPressed: pokemonStoreState.loading ? null : onPressed,
        icon: const Icon(Icons.replay_outlined),
        label: const Text('Retry'),
      ),
    );
  }
}
