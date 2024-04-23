import 'package:versotech_pokemon/models/error.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';

sealed class PokemonListState {
  const PokemonListState();
}

final class LoadingPokemons extends PokemonListState {}

final class FetchedPokemons extends PokemonListState {
  const FetchedPokemons({required this.pokemons});

  final List<SimplePokemon> pokemons;
}

final class ErrorFetchingPokemons extends PokemonListState {
  const ErrorFetchingPokemons({required this.error});

  final ApiException error;
}
