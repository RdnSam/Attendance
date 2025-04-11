import 'package:dio/dio.dart';

class DioConfig {
  static Dio getInstance({String? token}) {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://dev.kiraproject.id',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ));

    // Optional: log interceptor
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
