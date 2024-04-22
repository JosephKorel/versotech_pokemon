final class PokemonEntity {
  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.images,
    required this.abilities,
    required this.types,
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

    final types = (json['types'] as List<dynamic>)
        .map((e) => Type.fromJson(e as Map<String, dynamic>))
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
    );
  }

  final int id;
  final String name;
  final int height;
  final int weight;
  final PokemonImage images;
  final List<Type> types;
  final List<Ability> abilities;
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
  const Ability({required this.id, this.description = ''});

  // The id to query the API for detailed information
  // About the ability
  final String id;
  final String description;

  factory Ability.fromJson(Map<String, dynamic> json) {
    final urlSplit = (json['ability']['url'] as String).split('/');
    return Ability(id: urlSplit[urlSplit.length - 2]);
  }
}

final class Type {
  const Type({required this.type});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(type: json['type']['name']);
  }

  final String type;
}
