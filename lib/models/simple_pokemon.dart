// Unfortunatelly, when querying for a list of pokemons, the api
// only gives the name and URL for the full details, for each pokemon. But on the main screen
// all we need is to show the name and the picture of it, so it would be
// incredibily slow to fetch all the details of each pokemon. So this class has the essential
// information that we need to show in the main screen
final class SimplePokemon {
  final String name;
  final String imageUrl;
  final String id;

  String get idLabel => switch (id.toString().length) {
        1 => '#00$id',
        2 => '#0$id',
        _ => '#$id'
      };

  const SimplePokemon(
      {required this.name, required this.id, required this.imageUrl});

  // Here we can access the pokemon image by putting /[pokemon name].png at the end of the URL
  static const _imageUrlBasePath =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown';

  factory SimplePokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final urlSplit = (json['url'] as String).split('/');
    final id = urlSplit[urlSplit.length - 2];

    return SimplePokemon(
      name: name,
      id: id,
      imageUrl: '$_imageUrlBasePath/$id.gif',
    );
  }

  factory SimplePokemon.mock() =>
      const SimplePokemon(name: 'john', id: '2', imageUrl: 'url');
}
