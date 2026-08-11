class UserProfileModel {
  final String name;
  final String email;
  final int level;
  final int xp;
  final int totalPoints;
  final int savedPlaces;
  final int activeQuests;

  const UserProfileModel({
    required this.name,
    required this.email,
    required this.level,
    required this.xp,
    required this.totalPoints,
    required this.savedPlaces,
    required this.activeQuests,
  });
}
