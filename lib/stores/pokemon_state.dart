import 'package:mobx/mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

part 'pokemon_state.g.dart';

class PokemonStateStore = _PokemonStateStoreBase with _$PokemonStateStore;

abstract class _PokemonStateStoreBase with Store {
  final pokemonUsecase = PokemonUsecase(
    locator.get<PokemonUsecaseInterface>(),
  );

/*   @observable
  final PokemonListState _pokemonState = LoadingPokemons();

  @action
  Future<void> fetchPokemons() async {
    final newState = await _pokemonUsecase.fetchPokemons(params);
  } */
}
