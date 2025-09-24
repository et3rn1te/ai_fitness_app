import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUploadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadInitialData() async {
    await uploadWorkouts();
    await uploadWorkoutTypes();
    await uploadBodyParts();
    // ... other collections
  }

  Future<void> uploadWorkouts() async {
    try {
      // Read from JSON file
      final String jsonString = await rootBundle.loadString(
        'lib/assets/data/workouts.json',
      );
      final data = json.decode(jsonString);
      final workouts = data['workouts'] as List;

      // Upload each workout
      for (var workout in workouts) {
        await _firestore.collection('workouts').add(workout);
      }

      print('Workouts uploaded successfully');
    } catch (e) {
      print('Error uploading workouts: $e');
    }
  }

  Future<void> uploadWorkoutTypes() async {
    try {
      // Read from JSON file
      final String jsonString = await rootBundle.loadString(
        'lib/assets/data/workout_types.json',
      );
      final data = json.decode(jsonString);
      final workoutTypes = data['workout_types'] as List;

      // Upload each workout type
      for (var workoutType in workoutTypes) {
        await _firestore.collection('workout_types').add(workoutType);
      }

      print('Workout types uploaded successfully');
    } catch (e) {
      print('Error uploading workout types: $e');
    }
  }

  Future<void> uploadBodyParts() async {
    try {
      // Read from JSON file
      final String jsonString = await rootBundle.loadString(
        'lib/assets/data/body_parts.json',
      );
      final data = json.decode(jsonString);
      final bodyParts = data['body_parts'] as List;

      // Upload each body part
      for (var bodyPart in bodyParts) {
        await _firestore.collection('body_parts').add(bodyPart);
      }

      print('Body Parts uploaded successfully');
    } catch (e) {
      print('Error uploading Body Parts: $e');
    }
  }

  // Similar methods for other collections...
}
