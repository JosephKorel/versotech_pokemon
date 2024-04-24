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
        color: onPrimary,
        // border: Border.all(color: onSurface.withOpacity(0.1)),
        /* boxShadow: [
          BoxShadow(
            color: onSurface.withOpacity(0.1),
            spreadRadius: 1,
            offset: const Offset(0, 1),
            blurRadius: 1,
          )
        ], */
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
        decoration: BoxDecoration(
            color: context.background,
            border: Border.all(color: context.onSurface),
            borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            name,
            style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w800, color: context.onSurface),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _PokemonId extends StatelessWidget {
  const _PokemonId({super.key, required this.pokemonId});

  final String pokemonId;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.onSurface.withOpacity(0.8),
        ),
        color: context.background,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Text(
          pokemonId,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w800,
            color: context.onSurface,
          ),
          textAlign: TextAlign.center,
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
            Align(
              alignment: Alignment.topRight,
              child: _PokemonId(
                pokemonId: pokemon.idLabel,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: PokemonAvatar(pokemon: pokemon),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _Name(name: pokemon.name.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
