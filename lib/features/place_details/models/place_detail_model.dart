class NearbyPlaceModel {
  final String id;
  final String name;
  final String imageUrl;
  final double distanceKm;

  const NearbyPlaceModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.distanceKm,
  });

  factory NearbyPlaceModel.fromJson(Map<String, dynamic> json) {
    return NearbyPlaceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      distanceKm: (json['distanceKm'] as num).toDouble(),
    );
  }
}

class PlaceDetailModel {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final String? heroVideoUrl;
  final double rating;
  final String priceLabel;
  final String sectionTitle;
  final String description;
  final String oracleWisdom;
  final String openingHours;
  final String bestTime;
  final List<NearbyPlaceModel> nearbyPlaces;

  const PlaceDetailModel({
    required this.id,
    required this.name,
    required this.location,
    required this.heroImageUrl,
    this.heroVideoUrl,
    required this.rating,
    required this.priceLabel,
    required this.sectionTitle,
    required this.description,
    required this.oracleWisdom,
    required this.openingHours,
    required this.bestTime,
    required this.nearbyPlaces,
  });

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String? ?? '',
      heroImageUrl: json['heroImageUrl'] as String? ?? '',
      heroVideoUrl: json['heroVideoUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      priceLabel: json['priceLabel'] as String? ?? '',
      sectionTitle: json['sectionTitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      oracleWisdom: json['oracleWisdom'] as String? ?? '',
      openingHours: json['openingHours'] as String? ?? '',
      bestTime: json['bestTime'] as String? ?? '',
      nearbyPlaces: (json['nearbyPlaces'] as List? ?? [])
          .map((e) => NearbyPlaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
