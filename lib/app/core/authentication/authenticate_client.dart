import 'package:dio/dio.dart';

class AuthenticateApi {
  final Dio _dio = Dio();

  Future<Response> login(String? email, String? password) async {
    try {
      Response response = await _dio.post(
        'http://ubk.getaplikasi.id/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> logout(String token) async {
    try {
      Response response = await _dio.post(
        'http://ubk.getaplikasi.id/api/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token}',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  
}