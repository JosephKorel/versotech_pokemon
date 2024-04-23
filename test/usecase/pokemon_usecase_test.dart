import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_state.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

class MockUsecaseInterface extends Mock implements PokemonUsecaseInterface {}

void main() {
  const requestParams = PokemonListRequest(pagination: ApiPagination());
  final dioException = DioException(
    requestOptions: RequestOptions(path: 'exception'),
    type: DioExceptionType.connectionError,
  );
  late final PokemonUsecase pokemonUsecase;
  late final PokemonUsecaseInterface interface;
  setUpAll(() {
    interface = MockUsecaseInterface();
    pokemonUsecase = PokemonUsecase(interface);
  });

  group('Tests for the pokemon usecase implementation', () {
    test(
        'When interface returns list of pokemon, usecase method should return FetchedPokemons',
        () async {
      // stub
      when(() => interface.fetchPokemons(requestParams))
          .thenAnswer((invocation) async => <SimplePokemon>[]);

      // act
      final pokemonState = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(
        () => interface.fetchPokemons(requestParams),
      ).called(1);
      expect(pokemonState, isA<PokemonListState>());
      expect(pokemonState, isA<FetchedPokemons>());
    });

    test('When interface throws an error, should return ErrorFetchingPokemons',
        () async {
      // stub
      when(() => interface.fetchPokemons(requestParams))
          .thenThrow(dioException);

      // act
      final pokemonState = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(
        () => interface.fetchPokemons(requestParams),
      ).called(1);
      expect(pokemonState, isA<PokemonListState>());
      expect(pokemonState, isA<ErrorFetchingPokemons>());
    });

    test(
        'When error type is connectionError, should show connection unstable message',
        () async {
      const connectioErrorMsg = 'Seems like your connection is unstable.';

      // stub
      when(() => interface.fetchPokemons(requestParams))
          .thenThrow(dioException);

      // act
      final pokemonState = await pokemonUsecase.fetchPokemons(requestParams);
      final errorMsg = (pokemonState as ErrorFetchingPokemons).error.message;

      // assert
      expect(errorMsg, connectioErrorMsg);
    });
  });
}
