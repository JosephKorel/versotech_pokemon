import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:versotech_pokemon/domain/pokemon_abilities.dart';
import 'package:versotech_pokemon/locator.dart';
import 'package:versotech_pokemon/models/pokemon_entity.dart';
import 'package:versotech_pokemon/stores/fetched_pokemons.dart';
import 'package:versotech_pokemon/theme/utils.dart';
import 'package:versotech_pokemon/views/pokemon_details/controller/pokemon_details.dart';

class _LoadingAbility extends StatelessWidget {
  const _LoadingAbility({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _FailedToGetAbility extends StatelessWidget {
  const _FailedToGetAbility({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}

class _AbilityDescription extends StatelessWidget {
  const _AbilityDescription({super.key, required this.ability});

  final PokemonAbilityState ability;

  @override
  Widget build(BuildContext context) {
    return switch (ability) {
      LoadingAbility() => const _LoadingAbility(),
      FailedToGetAbility(error: final e) =>
        _FailedToGetAbility(message: e.message),
      LoadedAbility(ability: final a) => Text(
          a.description,
          textAlign: TextAlign.justify,
          style: context.bodyMedium.copyWith(
            fontStyle: FontStyle.italic,
            color: context.onSurface.withOpacity(
              0.7,
            ),
          ),
        )
    };
  }
}

class _AbilityTile extends StatefulWidget {
  const _AbilityTile({super.key, required this.ability});

  final Ability ability;

  @override
  State<_AbilityTile> createState() => _AbilityTileState();
}

class _AbilityTileState extends State<_AbilityTile> with AbilityController {
  late PokemonAbilityState _ability;

  Future<void> _fetchAbility() async {
    final loadedAbility = await getAbility(widget.ability);
    setState(() {
      _ability = loadedAbility;
    });
  }

  @override
  void initState() {
    super.initState();

    // Ability already loaded, no need to fetch it
    if (widget.ability.description.isNotEmpty) {
      _ability = LoadedAbility(ability: widget.ability);
      return;
    }

    // Set loading and fetch its details
    _ability = LoadingAbility();
    _fetchAbility();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.ability.label,
        style: context.titleMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      childrenPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      children: [_AbilityDescription(ability: _ability)],
    );
  }
}

class AbilitiesTab extends StatelessWidget {
  const AbilitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonAbilities = locator.get<LoadedPokemonStore>().pokemonAbilities;

    return Observer(
      builder: (context) => ListView.builder(
        padding: const EdgeInsets.only(top: 16),
        itemCount: pokemonAbilities.length,
        itemBuilder: (context, index) =>
            _AbilityTile(ability: pokemonAbilities[index]),
      ),
    );
  }
}
