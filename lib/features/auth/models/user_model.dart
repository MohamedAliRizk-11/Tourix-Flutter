class UserModel {
  final String id;
  final String fullName;
  final String email;
  final int level;
  final int xp;
  final String? token;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.level = 1,
    this.xp = 0,
    this.token,
  });

  factory UserModel.fromAuthResponse(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;
    return UserModel(
      id: user['id'] as String,
      fullName: user['fullName'] as String,
      email: user['email'] as String,
      level: user['level'] as int? ?? 1,
      xp: user['xp'] as int? ?? 0,
      token: json['token'] as String,
    );
  }

  factory UserModel.fromProfileJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      level: json['level'] as int? ?? 1,
      xp: json['xp'] as int? ?? 0,
    );
  }
}
