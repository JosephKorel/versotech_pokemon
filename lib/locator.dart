import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/data/api_implementation.dart';
import 'package:versotech_pokemon/dio/client.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/shared_pref/interface.dart';
import 'package:versotech_pokemon/shared_pref/theme.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';
import 'package:versotech_pokemon/stores/theme.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase_impl.dart';

final locator = GetIt.instance;

Future<void> setUpLocation({bool testing = false}) async {
  locator.allowReassignment = testing;

  if (!testing) {
    final sharedPref = await SharedPreferences.getInstance();

    locator.registerLazySingleton<SharedPreferences>(() => sharedPref);
  }

  locator.registerLazySingleton<SharedPrefService>(
      () => ThemeLocalImplementation());

  locator.registerLazySingleton<ThemeLocalService>(
      () => ThemeLocalService(locator.get<SharedPrefService>()));

  // Dependency
  locator.registerLazySingleton<RepositoryInterface>(
      () => ApiImplementation(DioClient()));

  locator.registerLazySingleton<PokemonUsecaseInterface>(
      () => PokemonUsecaseImplementation(locator<RepositoryInterface>()));

  locator.registerLazySingleton<PokemonUsecaseService>(
      () => PokemonUsecase(locator.get<PokemonUsecaseInterface>()));

  //

  // Global context key
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>(debugLabel: 'routerKey'));

  // Stores
  locator.registerLazySingleton(() => ThemeStore());
  locator.registerLazySingleton(
    () => PaginationStore(),
    dispose: (param) => param.reset(),
  );
  locator.registerLazySingleton(
    () => PokemonListStore(),
    dispose: (param) => param.reset(),
  );
  locator.registerLazySingleton(
    () => PokemonStateStore(),
    dispose: (param) => param.reset(),
  );
  locator.registerLazySingleton(
    () => SinglePokemonStore(),
    dispose: (param) => param.reset(),
  );
  locator.registerLazySingleton(() => LoadedPokemonStore());
  locator.registerLazySingleton(() => ColorSchemesStore());
  //
}
