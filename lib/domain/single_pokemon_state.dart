import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class SinglePokemonState {
  const SinglePokemonState();
}

final class LoadingPokemon extends SinglePokemonState {
  const LoadingPokemon({required this.pokemonName});

  final String pokemonName;
}

final class LoadedPokemon extends SinglePokemonState {
  const LoadedPokemon({required this.pokemon});

  final PokemonEntity pokemon;
}

final class FailedToLoad extends SinglePokemonState {
  const FailedToLoad({this.error, this.stackStrace});

  final Object? error;
  final StackTrace? stackStrace;
}
