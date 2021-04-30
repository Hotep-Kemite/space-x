import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class Api {
  Dio _dio;

  Api() {
    _dio = Dio();
    _dio.options = BaseOptions(baseUrl: "https://api.spacexdata.com/v4");
  }

  Future<Response<List<dynamic>>> getUpcomingLaunches() async =>
      await _dio.get<List<dynamic>>("/launches/upcoming");
}
