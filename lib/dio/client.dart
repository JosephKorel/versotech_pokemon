import 'package:dio/dio.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

const _pokemonApiBaseUrl = 'https://pokeapi.co/api/v2/';

final class DioClient implements RepositoryInterface {
  static final _dioOptions = BaseOptions(baseUrl: _pokemonApiBaseUrl);
  static final _dio = Dio(_dioOptions);

  @override
  Future<Map<String, dynamic>?> get(ApiRequestParams params) async {
    try {
      return _dio
          .get<Map<String, dynamic>>(
            params.endpoint,
            queryParameters: params.queryParams(),
          )
          .then((value) => value.data);
    } catch (e) {
      rethrow;
    }
  }
}
