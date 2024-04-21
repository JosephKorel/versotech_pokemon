import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase_impl.dart';

import '../models/api_models.dart';

class MockApiRepository extends Mock implements RepositoryInterface {}

void main() {
  const requestParams = PokemonListRequest(pagination: ApiPagination());
  late final MockApiRepository repository;
  late final PokemonUsecaseImplementation pokemonUsecase;

  setUpAll(() {
    repository = MockApiRepository();
    pokemonUsecase = PokemonUsecaseImplementation(repository);
  });

  group('Tests for implementation of api', () {
    test('Should return list of pokemons from api call', () async {
      // stub
      when(() => repository.get(requestParams))
          .thenAnswer((_) => Future.value(apiJsonResponse));

      // act
      final pokemons = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      expect(pokemons, isA<List<PokemonEntity>>());
    });

    test('When api returns null, should throw exception', () async {
      // stub
      when(() => repository.get(requestParams))
          .thenAnswer((_) => Future.value(null));

      // act
      final pokemons = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      expect(pokemons, isA<List<PokemonEntity>>());
    });

    test('Verify that api throws DioException', () async {
      // stub
      when(() => repository.get(requestParams)).thenThrow(DioException(
        requestOptions: RequestOptions(path: 'exception'),
        type: DioExceptionType.connectionError,
      ));

      // act
      final pokemons = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      expect(pokemons, throwsA(isA<DioException>()));
    });
  });
}
