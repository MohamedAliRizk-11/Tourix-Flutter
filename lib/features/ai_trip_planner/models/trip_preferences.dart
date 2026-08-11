class TripPreferences {
  final String destination;
  final String duration;
  final String travelStyle;
  final List<String> interests;

  const TripPreferences({
    required this.destination,
    required this.duration,
    required this.travelStyle,
    required this.interests,
  });

  Map<String, dynamic> toJson() => {
    'destination': destination,
    'duration': duration,
    'travelStyle': travelStyle,
    'interests': interests,
  };
}
