import 'package:dio/dio.dart';

class PengumumanApi {
  final Dio _dio = Dio();

  Future<Response> fetchPengumuman(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/pengumuman',
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

  Future<Response> fetchDetailPengumuman(String token, String id) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/pengumuman/$id',
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