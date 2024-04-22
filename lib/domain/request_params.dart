// Class used to make the requests to the API

base class ApiRequestParams {
  final String endpoint;

  // For sending query parameters in the request
  Map<String, dynamic>? queryParams() => null;

  const ApiRequestParams({required this.endpoint});
}

final class SinglePokemonRequest extends ApiRequestParams {
  static const _baseEndpoint = 'pokemon';

  const SinglePokemonRequest({
    required super.endpoint,
  });

  factory SinglePokemonRequest.fromUrl(String url) {
    final urlSplit = url.split('/');
    final pokemonId = urlSplit[urlSplit.length - 2];
    return SinglePokemonRequest(endpoint: '$_baseEndpoint/$pokemonId');
  }
}

final class PokemonListRequest extends ApiRequestParams {
  static const _endpoint = 'pokemon';

  const PokemonListRequest({
    super.endpoint = _endpoint,
    required this.pagination,
  });

  final ApiPagination pagination;

  @override
  Map<String, dynamic>? queryParams() => pagination.toJson();
}

final class PokemonAbilityRequest extends ApiRequestParams {
  static const _endpoint = 'ability';

  const PokemonAbilityRequest({
    super.endpoint = _endpoint,
    required this.abilityId,
  });

  final String abilityId;
}

class ApiPagination {
  // Will only take 10 pokemons at a time
  static const _limit = 10;
  // Start from index 0
  static const _initialOffset = 0;

  const ApiPagination({
    this.limit = _limit,
    this.offset = _initialOffset,
  });

  final int limit;
  final int offset;

  Map<String, dynamic> toJson() => {'limit': limit, 'offset': offset};
}
