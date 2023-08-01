import 'package:dio/dio.dart';

class SiswaApi {
  final Dio _dio = Dio();

  Future<Response> fetchSiswa(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/siswa',
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

  Future<Response> fetchDetailSiswa(String token, String id) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/siswa/$id',
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

}