import 'package:dio/dio.dart';

class AgendaApi {
  final Dio _dio = Dio();

  Future<Response> fetchAgenda(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/agenda',
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

  Future<Response> fetchDetailAgenda(String token, String id) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/agenda/$id',
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