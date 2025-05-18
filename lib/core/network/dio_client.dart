import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    dio = Dio(options);

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
