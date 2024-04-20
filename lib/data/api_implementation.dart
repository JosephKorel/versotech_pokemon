import 'package:dio/dio.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

final class ApiImplementation implements RepositoryInterface {
  const ApiImplementation(this._client);

  final Dio _client;

  @override
  Future<Map<String, dynamic>?> get(ApiRequestParams params) async {
    try {
      return _client
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
