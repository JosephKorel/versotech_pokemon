import 'package:versotech_pokemon/models/error.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class PokemonAbilityState {
  const PokemonAbilityState();
}

final class LoadingAbility extends PokemonAbilityState {}

final class LoadedAbility extends PokemonAbilityState {
  const LoadedAbility({required this.ability});

  final Ability ability;
}

final class FailedToGetAbility extends PokemonAbilityState {
  const FailedToGetAbility({required this.error});

  final ApiException error;
}
