import 'package:dio/dio.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class PokemonListState {
  const PokemonListState();
}

final class LoadingPokemons extends PokemonListState {}

final class FetchedPokemons extends PokemonListState {
  const FetchedPokemons({required this.pokemons});

  final List<SimplePokemonEntity> pokemons;
}

final class ErrorFetchingPokemons extends PokemonListState {
  const ErrorFetchingPokemons({
    required this.message,
    this.error,
    this.stackStrace,
  });

  factory ErrorFetchingPokemons.fromDioException(DioException exception) {
    var msg = '';
    switch (exception.type) {
      case DioExceptionType.connectionError:
        msg = 'Seems like your connection is unstable.';
        break;

      case DioExceptionType.connectionTimeout:
        msg = "Can't connect to server. You connection might be unstable.";
        break;

      case DioExceptionType.sendTimeout:
        msg = "Sending timeout. You connection might be unstable.";
        break;

      case DioExceptionType.badResponse:
        msg = 'Invalid response from server.';
        break;

      default:
        msg = 'An unkown error happened.';
    }

    return ErrorFetchingPokemons(
      message: msg,
      stackStrace: exception.stackTrace,
      error: exception.error,
    );
  }

  final String message;
  final Object? error;
  final StackTrace? stackStrace;
}
