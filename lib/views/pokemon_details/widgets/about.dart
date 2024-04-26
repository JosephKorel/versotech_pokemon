import 'package:flutter/material.dart';
import 'package:versotech_pokemon/domain/pokemon_characteristics.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetch_single_pokemon.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/pokemon_details/controller/pokemon_details.dart';

class _LoadingCharacteristics extends StatelessWidget {
  const _LoadingCharacteristics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailedToLoadCharacteristics extends StatelessWidget {
  const _FailedToLoadCharacteristics({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}

class _CharacteristicText extends StatelessWidget {
  const _CharacteristicText({super.key, required this.characteristic});

  final Characteristic characteristic;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Text(
          '"${characteristic.description}"',
          style: context.bodyLarge.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class _ShowPokemonCharacteristics extends StatefulWidget {
  const _ShowPokemonCharacteristics({super.key, required this.characteristics});

  final List<Characteristic> characteristics;

  @override
  State<_ShowPokemonCharacteristics> createState() =>
      _ShowPokemonCharacteristicsState();
}

class _ShowPokemonCharacteristicsState
    extends State<_ShowPokemonCharacteristics> {
  var _viewingCharacteristic = 0;

  void _next() => setState(() {
        _viewingCharacteristic += 1;
      });

  void _previous() => setState(() {
        _viewingCharacteristic -= 1;
      });

  bool get _canGoToNext =>
      _viewingCharacteristic < widget.characteristics.length - 1;

  bool get _canGoToPrevious => _viewingCharacteristic > 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _CharacteristicText(
              characteristic: widget.characteristics[_viewingCharacteristic]),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _canGoToPrevious ? _previous : null,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color:
                    _canGoToPrevious ? context.onSurface : Colors.transparent,
              ),
            ),
            Expanded(
              child: Text(
                widget.characteristics[_viewingCharacteristic].version
                    .toUpperCase(),
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            if (_canGoToNext)
              IconButton(
                onPressed: _canGoToNext ? _next : null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _canGoToNext ? context.onSurface : Colors.transparent,
                ),
              )
          ],
        ),
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
        _FailedToLoadCharacteristics(
          message: e.message,
        ),
      LoadedCharacteristics(characteristics: final c) =>
        _ShowPokemonCharacteristics(characteristics: c)
    };
  }
}

class _PokemonDetais extends StatelessWidget {
  const _PokemonDetais({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonStore = locator.get<SinglePokemonStore>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.scale, color: context.onSurface.withOpacity(0.8)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Weight',
                    style: context.bodyMedium
                        .copyWith(color: context.onSurface.withOpacity(0.8)),
                  )
                ],
              ),
              const Divider(),
              Text(
                '${pokemonStore.pokemon.weightInKg} kg',
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.height, color: context.onSurface.withOpacity(0.8)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Height',
                    style: context.bodyMedium
                        .copyWith(color: context.onSurface.withOpacity(0.8)),
                  )
                ],
              ),
              const Divider(),
              Text(
                '${pokemonStore.pokemon.heightInM} m',
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Expanded(child: _PokemonCharacteristics()),
          Spacer(
            flex: 1,
          ),
          Expanded(child: _PokemonDetais())
        ],
      ),
    );
  }
}
