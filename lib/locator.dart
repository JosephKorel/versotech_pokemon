import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:versotech_pokemon/data/api_implementation.dart';
import 'package:versotech_pokemon/dio/client.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase_impl.dart';

final locator = GetIt.instance;

void setUpLocation() {
  // Dependency
  locator.registerLazySingleton<RepositoryInterface>(
      () => ApiImplementation(DioClient()));

  locator.registerLazySingleton<PokemonUsecaseInterface>(
      () => PokemonUsecaseImplementation(locator<RepositoryInterface>()));

  locator.registerLazySingleton<PokemonUsecase>(
      () => PokemonUsecase(locator.get<PokemonUsecaseInterface>()));
  //

  // Global context key
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>(debugLabel: 'routerKey'));

  // Stores
  locator.registerLazySingleton(() => PokemonListStore());
  locator.registerLazySingleton(() => PokemonStateStore());
  locator.registerLazySingleton(() => LoadedPokemonStore());
  locator.registerLazySingleton(() => FetchSinglePokemonStore());
  locator.registerLazySingleton(() => PaginationStore());
  locator.registerLazySingleton(() => ColorSchemesStore());
  //
}
