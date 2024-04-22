import 'package:versotech_pokemon/domain/request_params.dart';

final class SimplePokemonEntity {
  const SimplePokemonEntity({required this.id, required this.name});

  final String name;
  final String id;

  SinglePokemonRequest fetch() => SinglePokemonRequest.fromId(id);

  factory SimplePokemonEntity.fromJson(Map<String, dynamic> json) {
    final urlSplit = (json['url'] as String).split('/');
    final pokemonId = urlSplit[urlSplit.length - 2];
    return SimplePokemonEntity(name: json['name'], id: pokemonId);
  }
}

class PokemonEntity {
  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.images,
    required this.abilities,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites']?['other']?['official-artwork'];
    final gif = json['sprites']?['other']?['showdown']?['front-default'];
    final pokemonImage = PokemonImage(
      gif: gif,
      small: sprites?['front_default'],
      medium: sprites?['front_default'],
      large: sprites?['front_default'],
    );

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
    );
  }

  final int id;
  final String name;
  final int height;
  final int weight;
  final PokemonImage images;
  final List<Ability> abilities;
}

class PokemonImage {
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

class Ability {
  const Ability({required this.id, this.description = ''});

  // The id to query the API for detailed information
  // About the ability
  final String id;
  final String description;

  factory Ability.fromJson(Map<String, dynamic> json) {
    final urlSplit = (json['ability']['url'] as String).split('/');
    final abilityId = urlSplit[urlSplit.length - 2];
    return Ability(id: abilityId);
  }
}
