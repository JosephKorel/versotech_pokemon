import 'package:flutter/material.dart';
import 'package:versotech_pokemon/domain/pokemon_characteristics.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/theme/utils.dart';
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

class _CharacteristicText extends StatelessWidget {
  const _CharacteristicText({super.key, required this.characteristic});

  final Characteristic characteristic;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: constraints.maxHeight * .7,
            child: SingleChildScrollView(
              child: Text(
                characteristic.description,
                style: context.bodySmall.copyWith(
                  color: context.onSurface.withOpacity(0.7),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            characteristic.version.toUpperCase(),
            style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          )
        ],
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
      _viewingCharacteristic < widget.characteristics.length;

  bool get _canGoToPrevious => _viewingCharacteristic > 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
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
                child: _CharacteristicText(
                    characteristic:
                        widget.characteristics[_viewingCharacteristic]),
              ),
              if (_canGoToNext)
                IconButton(
                  onPressed: _canGoToNext ? _next : null,
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color:
                        _canGoToNext ? context.onSurface : Colors.transparent,
                  ),
                )
            ],
          ),
        ),
        const Spacer(
          flex: 3,
        )
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
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: _PokemonCharacteristics(),
    );
  }
}
