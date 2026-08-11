class QuestObjectiveModel {
  final String title;
  final String location;
  final double distanceKm;
  final int estMinutes;
  final String? placeId;

  const QuestObjectiveModel({
    required this.title,
    required this.location,
    required this.distanceKm,
    required this.estMinutes,
    this.placeId,
  });
}
