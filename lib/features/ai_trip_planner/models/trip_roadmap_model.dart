enum TripStopStatus { start, completed, current, upcoming, finish }

class TripStopModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? subtitleLabel;
  final TripStopStatus status;

  const TripStopModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.subtitleLabel,
    required this.status,
  });
}

class CurrentStopDetailModel {
  final String name;
  final String imageUrl;
  final String weatherLabel;
  final String description;
  final String openingHours;
  final String transportLabel;
  final String? placeId;

  const CurrentStopDetailModel({
    required this.name,
    required this.imageUrl,
    required this.weatherLabel,
    required this.description,
    required this.openingHours,
    required this.transportLabel,
    this.placeId,
  });
}

class TripRoadmapModel {
  final String title;
  final String subtitle;
  final List<TripStopModel> stops;
  final CurrentStopDetailModel currentStopDetail;

  const TripRoadmapModel({
    required this.title,
    required this.subtitle,
    required this.stops,
    required this.currentStopDetail,
  });
}
