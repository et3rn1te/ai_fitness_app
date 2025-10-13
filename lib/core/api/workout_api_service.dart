import 'dart:convert';
import 'package:ai_fitness_app/core/workouts/workout_card_model.dart';
import 'package:ai_fitness_app/core/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:http/http.dart' as http;

class WorkoutApiService {
  final String _baseUrl = "http://10.0.2.2:8080/api"; // For Android emulator

  Future<List<WorkoutSummary>> fetchWorkoutSummary({
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/workouts/search',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(
          utf8.decode(response.bodyBytes),
        );

        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          return data
              .map((dynamic item) => WorkoutSummary.fromJson(item))
              .toList();
        } else {
          final error =
              jsonResponse['error']?['message'] ?? 'Unknown API error';
          throw Exception('API Error: $error');
        }
      } else {
        throw Exception(
          'Failed to load workouts (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<List<WorkoutCard>> fetchWorkoutCard({
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/workouts/search',
    ).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(
          utf8.decode(response.bodyBytes),
        );

        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data'];
          return data
              .map((dynamic item) => WorkoutCard.fromJson(item))
              .toList();
        } else {
          final error =
              jsonResponse['error']?['message'] ?? 'Unknown API error';
          throw Exception('API Error: $error');
        }
      } else {
        throw Exception(
          'Failed to load workouts (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Future<WorkoutDetail> fetchWorkoutDetail(int workoutId) async {
    final uri = Uri.parse('$_baseUrl/workouts/$workoutId');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(
          utf8.decode(response.bodyBytes),
        );
        if (jsonResponse['success'] == true) {
          return WorkoutDetail.fromJson(jsonResponse['data']);
        } else {
          throw Exception('API Error: ${jsonResponse['error']['message']}');
        }
      } else {
        throw Exception(
          'Failed to load workout detail (Status: ${response.statusCode})',
        );
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
