import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/services/user_session.dart';
import '../models/user_profile_model.dart';

class ProfileService {
  final Dio _dio = DioClient.instance.dio;

  Future<UserProfileModel> getProfile() async {
    final response = await _dio.get(ApiConstants.profile);
    final sessionUser = UserSession.instance.currentUser;

    return UserProfileModel(
      name: sessionUser?.fullName ?? response.data['fullName'] as String,
      email: sessionUser?.email ?? response.data['email'] as String,
      level: response.data['level'] as int? ?? 1,
      xp: response.data['xp'] as int? ?? 0,
      totalPoints: response.data['totalPoints'] as int? ?? 0,
      savedPlaces: response.data['savedPlaces'] as int? ?? 0,
      activeQuests: response.data['activeQuests'] as int? ?? 0,
    );
  }
}
