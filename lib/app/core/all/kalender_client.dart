import 'package:dio/dio.dart';

class KalenderApi {
  final Dio _dio = Dio();

  Future<Response> fetchKalender(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/kelender-akademik',
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

  Future<Response> fetchDetailKalender(String token, String id) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/kalender-akademik/$id',
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