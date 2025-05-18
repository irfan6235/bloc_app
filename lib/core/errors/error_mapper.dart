import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failure.dart';

class ErrorMapper {
  static Failure map(dynamic error) {
    if (error is DioError || error is DioException) {
      final dioError = error;

      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return NetworkFailure("Connection timed out");
        case DioExceptionType.badResponse:
          final statusCode = dioError.response?.statusCode;
          final message =
              dioError.response?.data['message'] ?? "Something went wrong";
          if (statusCode == 401 || statusCode == 403) {
            return UnauthorizedFailure(message);
          } else {
            return ServerFailure(message);
          }
        case DioExceptionType.cancel:
          return NetworkFailure("Request cancelled");
        case DioExceptionType.unknown:
        default:
          return NetworkFailure("Unexpected error occurred");
      }
    } else if (error is UnauthorizedException) {
      return UnauthorizedFailure(error.message);
    } else {
      return ServerFailure("Unknown error: ${error.toString()}");
    }
  }
}
