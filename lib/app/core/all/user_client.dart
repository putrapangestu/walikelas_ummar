import 'package:dio/dio.dart';

class UserApi {
  final Dio _dio = Dio();

  Future<Response> fetchUser(String token, String email, String password) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/profile',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json'
          }
        )
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<Response> updateData(String token, String name, String phone, String address, String image) async {
    try {
      Response response = await _dio.post(
        'http://ubk.getaplikasi.id/api/profile/update',
        data: {
          'name': name,
          'phone': phone,
          'address': address,
          'profile_image': image
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token}',
            'Content-type': 'application/json'
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

}