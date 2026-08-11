class MapPlaceModel {
  final String id;
  final String name;
  final String city;
  final String category;
  final double latitude;
  final double longitude;

  const MapPlaceModel({
    required this.id,
    required this.name,
    required this.city,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  factory MapPlaceModel.fromJson(Map<String, dynamic> json) {
    return MapPlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String? ?? '',
      category: json['category'] as String? ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}
