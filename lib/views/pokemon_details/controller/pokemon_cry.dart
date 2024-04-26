import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/utils/navigation.dart';

mixin PokemonCryController {
  static const _errorMsg = 'Failed to play pokemon cry';
  final _pokemon = locator.get<LoadedPokemonStore>().currentPokemon;

  final _audioPlayer = AudioPlayer();

  void _onError(BuildContext context) => context.showSnackbar(_errorMsg);

  Future<void> playAudio(BuildContext context) async {
    try {
      await _audioPlayer.play(UrlSource(_pokemon.cry.url));
    } catch (e) {
      if (context.mounted) {
        _onError(context);
      }
    }
  }
}
