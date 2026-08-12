import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/services/user_session.dart';

import '../models/user_profile_model.dart';

class ProfileService {
  final Dio _dio = DioClient.instance.dio;

  Future<UserProfileModel> getProfile() async {
    final sessionUser = UserSession.instance.currentUser;

    if (sessionUser != null) {
      try {
        final response = await _dio.get(ApiConstants.profile);
        final data = response.data as Map<String, dynamic>;

        return UserProfileModel(
          name: sessionUser.fullName,
          email: sessionUser.email,
          level: data['level'] as int? ?? sessionUser.level,
          xp: data['xp'] as int? ?? sessionUser.xp,
          totalPoints: data['totalPoints'] as int? ?? 0,
          savedPlaces: data['savedPlaces'] as int? ?? 0,
          activeQuests: data['activeQuests'] as int? ?? 0,
        );
      } catch (_) {
        return UserProfileModel(
          name: sessionUser.fullName,
          email: sessionUser.email,
          level: sessionUser.level,
          xp: sessionUser.xp,
          totalPoints: 0,
          savedPlaces: 0,
          activeQuests: 0,
        );
      }
    }

    final response = await _dio.get(ApiConstants.profile);
    final data = response.data as Map<String, dynamic>;

    return UserProfileModel(
      name: data['fullName'] as String? ?? 'Tourix Explorer',
      email: data['email'] as String? ?? 'explorer@tourix.app',
      level: data['level'] as int? ?? 1,
      xp: data['xp'] as int? ?? 0,
      totalPoints: data['totalPoints'] as int? ?? 0,
      savedPlaces: data['savedPlaces'] as int? ?? 0,
      activeQuests: data['activeQuests'] as int? ?? 0,
    );
  }
}
