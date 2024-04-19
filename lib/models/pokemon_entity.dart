class PokemonEntity {
  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.images,
    required this.abilities,
  });

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
  });

  final String small;
  final String medium;
  final String large;
}

class Ability {
  const Ability({required this.id, this.description = ''});

  final int id;
  final String description;
}
