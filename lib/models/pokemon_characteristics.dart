import 'package:versotech_pokemon/models/error.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';

sealed class PokemonCharacteristicsState {
  const PokemonCharacteristicsState();
}

final class LoadingCharacteristic extends PokemonCharacteristicsState {}

final class LoadedCharacteristics extends PokemonCharacteristicsState {
  const LoadedCharacteristics({required this.characteristics});

  final List<Characteristic> characteristics;
}

final class FailedToGetCharacteristics extends PokemonCharacteristicsState {
  const FailedToGetCharacteristics({required this.error});

  final ApiException error;
}
