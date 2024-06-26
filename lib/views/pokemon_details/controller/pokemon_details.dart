import 'package:versotech_pokemon/domain/pokemon_usecase_int.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_abilities.dart';
import 'package:versotech_pokemon/models/pokemon_characteristics.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/models/request_params.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/stores/single_pokemon.dart';

mixin AbilityController {
  final _usecase = locator.get<PokemonUsecaseService>();
  final _loadedPokemonsStore = locator.get<LoadedPokemonStore>();

  Future<PokemonAbilityState> getAbility(Ability ability) async {
    final loadedAbility = await _usecase.getAbility(ability.apiRequest);

    // Save ability
    if (loadedAbility is LoadedAbility) {
      _loadedPokemonsStore.updatePokemonAbility(ability: loadedAbility.ability);
    }

    return loadedAbility;
  }
}

mixin CharacteristicsController {
  final _usecase = locator.get<PokemonUsecaseService>();
  final _pokemonStore = locator.get<SinglePokemonStore>();
  final _loadedPokemonStore = locator.get<LoadedPokemonStore>();

  Future<PokemonCharacteristicsState> getCharacteristics() async {
    final value = await _usecase.getCharacteristics(
      PokemonCharacteristicRequest.fromName(_pokemonStore.pokemon.name),
    );

    // Save characteristic
    if (value is LoadedCharacteristics) {
      _loadedPokemonStore.updatePokemonCharacteristic(
        characteristics: value.characteristics,
      );
    }

    return value;
  }
}
