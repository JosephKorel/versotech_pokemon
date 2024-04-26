import 'package:versotech_pokemon/data/client.dart';
import 'package:versotech_pokemon/domain/repository_interface.dart';
import 'package:versotech_pokemon/models/request_params.dart';

final class ApiImplementation implements RepositoryInterface {
  const ApiImplementation(this._client);

  final DioClient _client;

  @override
  Future<Map<String, dynamic>?> get(ApiRequestParams params) async {
    try {
      return _client.dio
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
