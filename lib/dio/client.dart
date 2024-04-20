import 'package:dio/dio.dart';

const _pokemonApiBaseUrl = 'https://pokeapi.co/api/v2/';

final class DioClient {
  static final _dioOptions = BaseOptions(baseUrl: _pokemonApiBaseUrl);
  static final _dio = Dio(_dioOptions);

  Dio get dio => _dio;
}
