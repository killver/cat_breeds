class BreedModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String origin;
  final int intelligence;
  final int adaptability;
  final String lifeSpan;

  BreedModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.origin,
      required this.intelligence,
      required this.adaptability,
      required this.lifeSpan});

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        imageUrl: json['image'] != null && json['image']['url'] != null
            ? json['image']['url']
            : '',
        origin: json['origin'] ?? '',
        intelligence: json['intelligence'] ?? '',
        adaptability: json['adaptability'] ?? '',
        lifeSpan: json['life_span'] ?? '');
  }
}
