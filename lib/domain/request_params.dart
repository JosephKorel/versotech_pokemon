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

  factory SinglePokemonRequest.fromName(String name) {
    return SinglePokemonRequest(endpoint: '$_baseEndpoint/$name');
  }
}

final class PokemonListRequest extends ApiRequestParams {
  static const _endpoint = 'pokemon';

  const PokemonListRequest({
    super.endpoint = _endpoint,
    required this.pagination,
  });

  final ApiPagination pagination;

  PokemonListRequest nextPage() =>
      PokemonListRequest(pagination: pagination.nextPage);

  @override
  Map<String, dynamic>? queryParams() => pagination.toJson();
}

final class PokemonAbilityRequest extends ApiRequestParams {
  static const _baseEndpoint = 'ability';

  const PokemonAbilityRequest({
    super.endpoint = _baseEndpoint,
  });

  factory PokemonAbilityRequest.fromName(String abilityName) =>
      PokemonAbilityRequest(endpoint: '$_baseEndpoint/$abilityName');
}

final class PokemonCharacteristicRequest extends ApiRequestParams {
  static const _baseEndpoint = 'pokemon-species';

  const PokemonCharacteristicRequest({
    super.endpoint = _baseEndpoint,
  });

  factory PokemonCharacteristicRequest.fromName(String name) =>
      PokemonCharacteristicRequest(endpoint: '$_baseEndpoint/$name');
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

  ApiPagination get nextPage => ApiPagination(offset: offset + _limit);

  final int limit;
  final int offset;

  Map<String, dynamic> toJson() => {'limit': limit, 'offset': offset};
}
