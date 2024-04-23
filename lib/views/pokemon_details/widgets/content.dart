import 'package:flutter/material.dart';

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
          child: Container(
            color: Colors.red,
          ),
        )
      ],
    );
  }
}
