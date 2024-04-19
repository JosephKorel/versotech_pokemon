import 'package:versotech_pokemon/dio/client.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/domain/request_params.dart';

final class ApiImplementation implements RepositoryInterface {
  const ApiImplementation(this._client);

  final DioClient _client;

  @override
  Future<Map<String, dynamic>?> get(ApiRequestParams params) =>
      _client.get(params);
}
