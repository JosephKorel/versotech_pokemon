import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class PokemonListState {
  const PokemonListState();
}

final class LoadingPokemons extends PokemonListState {}

final class FetchedPokemons extends PokemonListState {
  const FetchedPokemons({required this.pokemons});

  final List<PokemonEntity> pokemons;
}

final class ErrorFetchingPokemons extends PokemonListState {
  const ErrorFetchingPokemons({
    required this.message,
    this.error,
    this.stackStrace,
  });

  final String message;
  final Object? error;
  final StackTrace? stackStrace;
}
