import 'package:cloud_firestore/cloud_firestore.dart';

class BodyPartModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int order;

  BodyPartModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.order,
  });

  factory BodyPartModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BodyPartModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      order: data['order'] ?? 0,
    );
  }
}
