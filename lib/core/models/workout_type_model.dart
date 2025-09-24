import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutTypeModel {
  final String id;
  final String name;
  final String description;
  final int order;

  WorkoutTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.order,
  });

  factory WorkoutTypeModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return WorkoutTypeModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      order: data['order'] ?? 0,
    );
  }
}
