final class SimplePokemon {
  final String name;
  final String imageUrl;

  const SimplePokemon({required this.name, required this.imageUrl});

  static const _imageUrlBasePath =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork';

  factory SimplePokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final urlSplit = (json['url'] as String).split('/');
    final id = urlSplit[urlSplit.length - 2];

    return SimplePokemon(name: name, imageUrl: '$_imageUrlBasePath/$id.png');
  }
}
