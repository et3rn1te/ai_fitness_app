class BodyPart {
  final int id;
  final String name;
  final String? imageUrl;

  BodyPart({required this.id, required this.name, this.imageUrl});

  factory BodyPart.fromJson(Map<String, dynamic> json) {
    return BodyPart(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
