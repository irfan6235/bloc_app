import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<String> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return response.data['token'];
    } else {
      throw Exception('Login failed');
    }
  }
}
