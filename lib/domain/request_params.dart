// Class used to make the requests to the API
base class ApiRequestParams {
  final String endpoint;

  // For sending query parameters in the request
  Map<String, dynamic>? queryParams() => null;

  const ApiRequestParams({required this.endpoint});
}

final class PokemonListRequest extends ApiRequestParams {
  static const _endpoint = 'pokemon';
  // Will only take 10 pokemons at a time
  static const _limit = 10;
  // Start from index 0
  static const _initialOffset = 0;

  const PokemonListRequest({
    super.endpoint = _endpoint,
    this.limit = _limit,
    this.offset = _initialOffset,
  });

  final int limit;
  final int offset;

  @override
  Map<String, dynamic>? queryParams() => {'limit': limit, 'offset': offset};
}

final class PokemonAbilityRequest extends ApiRequestParams {
  static const _endpoint = 'ability';

  const PokemonAbilityRequest({
    super.endpoint = _endpoint,
    required this.abilityId,
  });

  final String abilityId;
}
