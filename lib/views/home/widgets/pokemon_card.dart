import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/stores/pokemon_details.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/utils/navigation.dart';
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
    final pokemonDetailStore = locator.get<PokemonDetailsStore>();

    // Navigate to see details of the pokemon
    void onTap() {
      // pokemonDetailStore.setPokemon(pokemon);

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

class _PokemonAvatar extends StatelessWidget {
  const _PokemonAvatar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: DecoratedBox(
          decoration: context.avatarDecoration,
          child: const SizedBox.expand(),
        ),
      ),
      SizedBox.expand(
        child: CachedNetworkImage(
          imageUrl: url,
        ),
      ),
    ]);
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
            _PokemonAvatar(
              url: pokemon.imageUrl,
            ),
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
