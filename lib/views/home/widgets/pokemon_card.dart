import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/utils/navigation.dart';
import 'package:versotech_pokemon/views/home/widgets/pokemon_avatar.dart';
import 'package:versotech_pokemon/views/pokemon_details/main.dart';

// To make the widgets more legible
extension _CardTheme on BuildContext {
  BoxDecoration get containerDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: background,
        border: Border.all(color: onSurface.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
            blurRadius: 1,
          )
        ],
      );

  BoxDecoration get avatarDecoration => BoxDecoration(
        shape: BoxShape.circle,
        color: background,
        border: Border.all(color: onSurface.withOpacity(0.8)),
      );

  BoxDecoration get nameDecoration => BoxDecoration(
        border: Border.all(
          color: onSurface.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(8),
        color: background,
        boxShadow: [
          BoxShadow(
            color: onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
            blurRadius: 1,
          )
        ],
      );
}
//

class _CardContainer extends StatelessWidget {
  const _CardContainer({super.key, required this.child, required this.pokemon});

  final SimplePokemon pokemon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<FetchSinglePokemonStore>();

    // Navigate to see details of the pokemon
    void onTap() {
      pokemonStore.fetchPokemon(pokemon.name);

      context.navigate(const PokemonDetailsView());
    }

    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: context.containerDecoration,
          child: child,
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: context.nameDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            name,
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.pokemon});

  final SimplePokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      pokemon: pokemon,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            PokemonAvatar(pokemon: pokemon),
            Align(
              alignment: Alignment.bottomCenter,
              child: _Name(name: pokemon.name.toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}
