class TripActivityModel {
  final String time;
  final String name;
  final String description;
  final double estimatedCost;

  const TripActivityModel({
    required this.time,
    required this.name,
    required this.description,
    required this.estimatedCost,
  });

  factory TripActivityModel.fromJson(Map<String, dynamic> json) {
    return TripActivityModel(
      time: json['time'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble() ?? 0,
    );
  }
}

class TripDayModel {
  final int day;
  final String title;
  final String description;
  final List<TripActivityModel> activities;

  const TripDayModel({
    required this.day,
    required this.title,
    required this.description,
    required this.activities,
  });

  factory TripDayModel.fromJson(Map<String, dynamic> json) {
    return TripDayModel(
      day: json['day'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      activities: (json['activities'] as List? ?? [])
          .map((e) => TripActivityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GeneratedTripModel {
  final String title;
  final String description;
  final double estimatedBudget;
  final String duration;
  final List<TripDayModel> days;
  final List<String> tips;

  const GeneratedTripModel({
    required this.title,
    required this.description,
    required this.estimatedBudget,
    required this.duration,
    required this.days,
    required this.tips,
  });

  factory GeneratedTripModel.fromJson(Map<String, dynamic> json) {
    return GeneratedTripModel(
      title: json['title'] as String? ?? 'Your AI Travel Plan',
      description: json['description'] as String? ?? '',
      estimatedBudget: (json['estimatedBudget'] as num?)?.toDouble() ?? 0,
      duration: json['duration'] as String? ?? '',
      days: (json['days'] as List? ?? [])
          .map((e) => TripDayModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tips: (json['tips'] as List? ?? []).map((e) => e as String).toList(),
    );
  }
}
