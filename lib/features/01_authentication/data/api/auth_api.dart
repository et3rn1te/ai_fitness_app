import 'package:ai_fitness_app/core/api/api_service.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

// This class is responsible for making the *actual* HTTP calls.
class AuthApi {
  final Dio _dio;
  final String _googleAuthUrl =
      'http://localhost:8080/api/oauth2/authorization/google'; // <-- The URL

  // It depends on the central ApiClient
  AuthApi(ApiClient apiClient) : _dio = apiClient.client;

  Future<Response> login(String email, String password) {
    return _dio.post(
      '/auth/login', // We will build this endpoint
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _dio.post(
      '/auth/register', // We will build this endpoint
      data: {'name': name, 'email': email, 'password': password},
    );
  }

  Future<void> startGoogleSignInFlow() async {
    final Uri url = Uri.parse(_googleAuthUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // We use externalApplication to open the browser
      // instead of an in-app webview
      throw Exception('Could not launch $_googleAuthUrl');
    }
  }

  Future<Response> getUserProfile(String token) {
    return _dio.get(
      '/users/me', // We will build this endpoint
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
