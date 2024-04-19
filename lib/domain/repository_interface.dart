import 'package:versotech_pokemon/domain/request_params.dart';

interface class RepositoryInterface {
  // Originally there would be more methods here, but the api
  // Has just one method
  Future<Map<String, dynamic>?> get(ApiRequestParams params) =>
      throw UnimplementedError();
}
