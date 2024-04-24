import 'package:flutter/material.dart';
import 'package:versotech_pokemon/domain/pokemon_characteristics.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/views/pokemon_details/controller/characteristics.dart';

class _LoadingCharacteristics extends StatelessWidget {
  const _LoadingCharacteristics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailedToLoadCharacteristics extends StatelessWidget {
  const _FailedToLoadCharacteristics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error_outline_outlined),
    );
  }
}

class _ShowPokemonCharacteristics extends StatelessWidget {
  const _ShowPokemonCharacteristics({super.key, required this.characteristics});

  final List<Characteristic> characteristics;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(characteristics.first.description),
      ],
    );
  }
}

class _PokemonCharacteristics extends StatefulWidget {
  const _PokemonCharacteristics({super.key});

  @override
  State<_PokemonCharacteristics> createState() =>
      __PokemonCharacteristicsState();
}

class __PokemonCharacteristicsState extends State<_PokemonCharacteristics>
    with CharacteristicsController {
  PokemonCharacteristicsState _characteristic = LoadingCharacteristic();

  Future<void> fetchCharacteristics() async {
    _characteristic = await getCharacteristics();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCharacteristics();
  }

  @override
  Widget build(BuildContext context) {
    return switch (_characteristic) {
      LoadingCharacteristic() => const _LoadingCharacteristics(),
      FailedToGetCharacteristics(error: final e) =>
        const _FailedToLoadCharacteristics(),
      LoadedCharacteristics(characteristics: final c) =>
        _ShowPokemonCharacteristics(characteristics: c)
    };
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PokemonCharacteristics();
  }
}
