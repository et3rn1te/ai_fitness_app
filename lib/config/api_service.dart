import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = "http://10.0.2.2:8080/api";

  // A private constructor to prevent external instantiation.
  ApiClient._();

  // Singleton instance
  static final ApiClient _instance = ApiClient._();

  // Factory constructor to return the singleton instance
  factory ApiClient() {
    return _instance;
  }

  /// Generic GET request handler. It is used by all other services.
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/$endpoint',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);
      return _handleResponse(response, endpoint);
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  /// Handles the response, checking status codes and parsing JSON.
  dynamic _handleResponse(http.Response response, String endpoint) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(
        utf8.decode(response.bodyBytes),
      );

      if (jsonResponse['success'] == true && jsonResponse.containsKey('data')) {
        return jsonResponse['data']; // Return only the 'data' payload
      } else {
        final error = jsonResponse['error']?['message'] ?? 'Unknown API error';
        throw Exception('API Error: $error');
      }
    } else {
      throw Exception(
        'Failed to load data from $endpoint (Status: ${response.statusCode})',
      );
    }
  }
}
