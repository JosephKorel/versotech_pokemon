import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/models/request_params.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/simple_pokemon.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase_impl.dart';

import '../models/api_models.dart';

class MockApiRepository extends Mock implements RepositoryInterface {}

class MockPokemonUsecaseInterface extends Mock
    implements PokemonUsecaseInterface {}

class MockPokemonUsecase extends Mock implements PokemonUsecaseService {}

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
          .thenAnswer((_) => Future.value(pokemonListJson));

      // act
      final pokemons = await pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      expect(pokemons, isA<List<SimplePokemon>>());
    });

    test('When api returns null, should throw exception', () async {
      // stub
      when(() => repository.get(requestParams))
          .thenAnswer((_) => Future.value());

      // act
      final pokemonCall = pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      await expectLater(pokemonCall, throwsException);
    });

    test('Verify that api throws DioException', () async {
      // stub
      when(() => repository.get(requestParams)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'exception'),
          type: DioExceptionType.connectionError,
        ),
      );

      // act
      final pokemonCall = pokemonUsecase.fetchPokemons(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      await expectLater(pokemonCall, throwsA(isA<DioException>()));
    });

    test('When api returns ability JSON, usecase should return Ability class',
        () async {
      // stub
      when(() => repository.get(requestParams))
          .thenAnswer((invocation) async => abilityResponse);

      // act
      final ability = await pokemonUsecase.getAbilityDescription(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      expect(ability, isA<Ability>());
    });

    test('When api returns ability JSON, usecase should return Ability class',
        () async {
      // stub
      when(() => repository.get(requestParams))
          .thenAnswer((invocation) async => abilityResponse);

      // act
      final ability = await pokemonUsecase.getAbilityDescription(requestParams);

      // assert
      verify(() => repository.get(requestParams)).called(1);
      expect(ability, isA<Ability>());
    });
  });
}
