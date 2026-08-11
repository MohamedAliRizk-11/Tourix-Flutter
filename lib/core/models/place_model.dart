class PlaceModel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double? rating;
  final int? reviewsCount;
  final String? category;
  final String? shortDescription;
  final double? distanceKm;
  final String? tag;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    this.rating,
    this.reviewsCount,
    this.category,
    this.shortDescription,
    this.distanceKm,
    this.tag,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviewsCount'] as int?,
      category: json['category'] as String?,
      shortDescription: json['shortDescription'] as String?,
      distanceKm: (json['distanceKm'] as num?)?.toDouble(),
      tag: json['tag'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'imageUrl': imageUrl,
    'rating': rating,
    'reviewsCount': reviewsCount,
    'category': category,
    'shortDescription': shortDescription,
    'distanceKm': distanceKm,
    'tag': tag,
  };
}
