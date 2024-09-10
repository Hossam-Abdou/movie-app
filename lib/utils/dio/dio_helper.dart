import 'package:dio/dio.dart';
import 'package:movie_app/utils/end_points/end_points.dart';

class DioHelper {
  static Dio? dio;

  // Initialize Dio
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  // GET request
  static Future<Response> getData({required String endPoint, String? token,})
  async {
    dio?.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
    };
    return await dio!.get("${EndPoints.baseUrl}$endPoint");
  }

  // POST request


  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      'Authorization': token != null ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }

}