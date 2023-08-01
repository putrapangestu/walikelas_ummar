import 'package:dio/dio.dart';

class TugasApi {
  final Dio _dio = Dio();

  Future<Response> fetchTugas(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/tugas',
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

  Future<Response> fetchTugasBulan(String token) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/tugas/bulan-ini',
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

  Future<Response> fetchDetailTugas(String token, String id) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/tugas/$id',
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

  Future<Response> fetchDetailTugasSiswa(String token, String id, String siswaID) async {
    try {
      Response response = await _dio.get(
        'http://ubk.getaplikasi.id/api/tugas/$id/siswa/$siswaID',
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
  
  Future<Response> createTugas(String token, List siswa, Map<String, dynamic> tugas) async {
    try {
      Response response = await _dio.post(
        'http://ubk.getaplikasi.id/api/tugas',
        data: {
          "siswa" : siswa,
          "tugas" : tugas
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

}