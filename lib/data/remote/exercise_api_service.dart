import 'dart:convert';
import 'package:ai_fitness_app/data/models/exercises/exercise_summary_model.dart';
import 'package:http/http.dart' as http;

class ExerciseApiService {
  final String _baseUrl = "http://10.0.2.2:8080/api";

  Future<List<ExerciseSummary>> fetchAllExercises() async {
    final uri = Uri.parse('$_baseUrl/exercises');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'] as List? ?? [];
          return data.map((item) => ExerciseSummary.fromJson(item)).toList();
        } else {
          throw Exception('API Error: ${jsonResponse['error']['message']}');
        }
      } else {
        throw Exception(
          'Failed to load exercises (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<List<ExerciseSummary>> searchExercises(
    Map<String, String> queryParams,
  ) async {
    final uri = Uri.parse(
      '$_baseUrl/exercises/search',
    ).replace(queryParameters: queryParams);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'] as List? ?? [];
          return data.map((item) => ExerciseSummary.fromJson(item)).toList();
        } else {
          final error =
              jsonResponse['error']?['message'] ?? 'Unknown API error';
          throw Exception('API Error: $error');
        }
      } else {
        throw Exception(
          'Failed to search exercises (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
