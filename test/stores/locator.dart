import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/stores/color_schemes.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/stores/pokemon_simple_store.dart';
import 'package:versotech_pokemon/stores/pokemon_state.dart';
import 'package:versotech_pokemon/stores/request_params.dart';

import '../usecase/pokemon_usecase_test.dart';
import '../usecase/pokemons_usecase_impl_test.dart';

final testingLocator = GetIt.instance;

void setUpTestingLocation() {
  // Dependency
  testingLocator
      .registerLazySingleton<RepositoryInterface>(() => MockApiRepository());

  testingLocator.registerLazySingleton<PokemonUsecaseInterface>(
      () => MockUsecaseInterface());

  testingLocator.registerLazySingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());

  testingLocator
      .registerLazySingleton<PokemonUsecaseService>(() => MockPokemonUsecase());
  //

  // Stores
  testingLocator.registerLazySingleton(
    () => PokemonListStore(),
    dispose: (param) => param.reset(),
  );
  testingLocator.registerLazySingleton(
    () => PokemonStateStore(),
    dispose: (param) => param.reset(),
  );
  testingLocator.registerLazySingleton(() => LoadedPokemonStore());
  testingLocator.registerLazySingleton(() => FetchSinglePokemonStore());
  testingLocator.registerLazySingleton(() => ColorSchemesStore());
  testingLocator.registerLazySingleton(() => PaginationStore());
  //
}
