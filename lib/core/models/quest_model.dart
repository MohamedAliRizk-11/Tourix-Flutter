class QuestModel {
  final String id;
  final String title;
  final String description;
  final String placeName;
  final double latitude;
  final double longitude;
  final String questType;
  final int rewardPoints;
  final String status;

  const QuestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.questType,
    required this.rewardPoints,
    required this.status,
  });

  factory QuestModel.fromJson(Map<String, dynamic> json) {
    return QuestModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      placeName: json['placeName']?.toString() ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      questType: json['questType']?.toString() ?? '',
      rewardPoints: (json['rewardPoints'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'placeName': placeName,
      'latitude': latitude,
      'longitude': longitude,
      'questType': questType,
      'rewardPoints': rewardPoints,
      'status': status,
    };
  }
}
