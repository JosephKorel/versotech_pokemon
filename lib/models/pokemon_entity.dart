import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

final class PokemonEntity {
  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.images,
    required this.abilities,
    required this.types,
    required this.stats,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites']?['other']?['official-artwork'];
    final gif = json['sprites']?['other']?['showdown']?['front_default'];
    final pokemonImage = PokemonImage(
      gif: gif,
      small: sprites?['front_default'],
      medium: sprites?['front_default'],
      large: sprites?['front_default'],
    );

    final types = (json['types'] as List<dynamic>)
        .map((e) => Type.fromJson(e as Map<String, dynamic>))
        .toList();

    final stats = (json['stats'] as List<dynamic>)
        .map((e) => Status.fromJson(e as Map<String, dynamic>))
        .toList();

    final abilities = (json['abilities'] as List<dynamic>)
        .map((e) => Ability.fromJson(e as Map<String, dynamic>))
        .toList();

    return PokemonEntity(
        id: json['id'],
        name: json['name'],
        height: json['height'],
        weight: json['weight'],
        images: pokemonImage,
        abilities: abilities,
        types: types,
        stats: stats);
  }

  final int id;
  final String name;
  final int height;
  final int weight;
  final PokemonImage images;
  final List<Type> types;
  final List<Ability> abilities;
  final List<Status> stats;
}

final class PokemonImage {
  const PokemonImage({
    required this.small,
    required this.medium,
    required this.large,
    required this.gif,
  });

  final String? gif;
  final String? small;
  final String? medium;
  final String? large;
}

final class Ability {
  const Ability({required this.id, required this.name, this.description = ''});

  // The id to query the API for detailed information
  // About the ability
  final String id;
  final String name;
  final String description;

  factory Ability.fromJson(Map<String, dynamic> json) {
    final name = json['ability']['name'];
    final urlSplit = (json['ability']['url'] as String).split('/');
    return Ability(
      id: urlSplit[urlSplit.length - 2],
      name: name,
    );
  }

  factory Ability.fromAbilityJson(Map<String, dynamic> json) {
    final ability = (json['effect_entries'] as List<dynamic>)
        .where((element) => element['language']['name'] == 'en')
        .first;

    return Ability(
      id: json['id'].toString(),
      name: json['name'],
      description: ability['effect'],
    );
  }
}

final class Type {
  const Type({required this.type});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(type: json['type']['name']);
  }

  final String type;
}

final class Status {
  const Status({required this.name, required this.value});

  final String name;
  final int value;

  IconData get icon => switch (name) {
        'hp' => RpgAwesome.hearts,
        'attack' => RpgAwesome.crossed_swords,
        'defense' => RpgAwesome.shield,
        'special-attack' => RpgAwesome.fireball_sword,
        'special-defense' => RpgAwesome.heavy_shield,
        'speed' => Icons.directions_run,
        _ => Icons.electric_bolt_rounded
      };

  factory Status.fromJson(Map<String, dynamic> json) {
    final value = json['base_stat'];
    final name = json['stat']['name'];
    return Status(name: name, value: value);
  }
}
