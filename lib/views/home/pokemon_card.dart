import 'package:flutter/material.dart';
import 'package:versotech_pokemon/domain/single_pokemon_state.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

class PokemonCard extends StatefulWidget {
  const PokemonCard({super.key, required this.simplePokemon});

  final SimplePokemonEntity simplePokemon;

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  SinglePokemonState _pokemonState = LoadingPokemon();
  final _pokemonUsecase = locator.get<PokemonUsecase>();

  Future<void> _fetchPokemon() async {
    _pokemonState =
        await _pokemonUsecase.fetchSinglePokemon(widget.simplePokemon.fetch());

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: switch (_pokemonState) {
        LoadingPokemon() => const _LoadingPokemon(),
        FailedToLoad() => const _FailedToLoadPokemon(),
        LoadedPokemon(pokemon: final p) => _LoadedPokemon(pokemon: p)
      },
    );
  }
}

class _LoadingPokemon extends StatelessWidget {
  const _LoadingPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailedToLoadPokemon extends StatelessWidget {
  const _FailedToLoadPokemon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.error));
  }
}

class _LoadedPokemon extends StatelessWidget {
  const _LoadedPokemon({super.key, required this.pokemon});

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        pokemon.name,
        style: context.titleLarge,
      ),
    );
  }
}
