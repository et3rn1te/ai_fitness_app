import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
    : dio = Dio(
        BaseOptions(
          // Your Spring Boot server's address
          baseUrl: 'http://localhost:8080/api',
          connectTimeout: const Duration(milliseconds: 5000),
          receiveTimeout: const Duration(milliseconds: 3000),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    // You can add interceptors here for logging or auth tokens
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // A getter to easily access the configured Dio instance
  Dio get client => dio;
}
