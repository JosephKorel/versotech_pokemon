import 'package:flutter/material.dart';
import 'package:versotech_pokemon/theme/utils.dart';

class PokemonMainContent extends StatelessWidget {
  const PokemonMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Expanded(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.background,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: context.onSurface.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: context.onSurface.withOpacity(0.1),
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                  )
                ],
              ),
              child: const SizedBox.expand(),
            ))
      ],
    );
  }
}
