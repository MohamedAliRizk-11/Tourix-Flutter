class QuestModel {
  final String id;
  final String title;
  final String description;
  final String placeName;
  final String questType;
  final int rewardPoints;
  final String status;
  final double? latitude;
  final double? longitude;

  const QuestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.placeName,
    required this.questType,
    required this.rewardPoints,
    required this.status,
    this.latitude,
    this.longitude,
  });

  factory QuestModel.fromJson(Map<String, dynamic> json) {
    return QuestModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      placeName: json['placeName'] as String? ?? '',
      questType: json['questType'] as String? ?? '',
      rewardPoints: json['rewardPoints'] as int? ?? 0,
      status: json['status'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}
