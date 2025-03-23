class BreedModel {
  final String id;
  final String name;
  final String description;
  String? imageUrl;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String lifeSpan;
  final String referenceImageId;

  BreedModel(
      {required this.id,
      required this.name,
      required this.description,
      this.imageUrl,
      required this.origin,
      required this.intelligence,
      required this.adaptability,
      required this.lifeSpan,
      required this.referenceImageId});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      origin: json['origin'] ?? '',
      intelligence: json['intelligence'] ?? '',
      adaptability: json['adaptability'] ?? '',
      lifeSpan: json['life_span'] ?? '',
      referenceImageId: json['reference_image_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
