import 'package:dio/dio.dart';

final class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.error,
    this.stackStrace,
  });

  factory ApiException.fromDioException(DioException exception) {
    var msg = '';
    switch (exception.type) {
      case DioExceptionType.connectionError:
        msg = 'Seems like your connection is unstable.';
        break;

      case DioExceptionType.connectionTimeout:
        msg = "Can't connect to server. You connection might be unstable.";
        break;

      case DioExceptionType.sendTimeout:
        msg = "Sending timeout. You connection might be unstable.";
        break;

      case DioExceptionType.badResponse:
        msg = 'Invalid response from server.';
        break;

      default:
        msg = 'An unkown error happened.';
    }

    return ApiException(
      message: msg,
      stackStrace: exception.stackTrace,
      error: exception.error,
    );
  }

  final String message;
  final Object? error;
  final StackTrace? stackStrace;
}
