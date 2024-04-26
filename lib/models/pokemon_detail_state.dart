import 'package:versotech_pokemon/models/error.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class SinglePokemonState {
  const SinglePokemonState();
}

final class LoadingPokemon extends SinglePokemonState {}

final class LoadedPokemon extends SinglePokemonState {
  const LoadedPokemon({required this.pokemon});

  final PokemonEntity pokemon;
}

final class FailedToGetPokemon extends SinglePokemonState {
  const FailedToGetPokemon({required this.error});

  final ApiException error;
}
