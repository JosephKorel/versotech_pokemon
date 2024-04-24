import 'package:versotech_pokemon/domain/pokemon_characteristics.dart';
import 'package:versotech_pokemon/domain/request_params.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/usecase/pokemons_usecase.dart';

mixin CharacteristicsController {
  final _usecase = locator.get<PokemonUsecase>();
  final _pokemonStore = locator.get<FetchSinglePokemonStore>();

  Future<PokemonCharacteristicsState> getCharacteristics() async {
    return await _usecase.getCharacteristics(
      PokemonCharacteristicRequest.fromName(_pokemonStore.pokemon.name),
    );
  }
}
