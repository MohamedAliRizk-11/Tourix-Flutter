import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/services/token_storage.dart';
import '../models/user_model.dart';

class AuthService {
  final Dio _dio = DioClient.instance.dio;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {'email': email, 'password': password},
    );
    final user = UserModel.fromAuthResponse(response.data);
    await TokenStorage.save(user.token!);
    return user;
  }

  Future<UserModel> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.register,
      data: {'fullName': fullName, 'email': email, 'password': password},
    );
    final user = UserModel.fromAuthResponse(response.data);
    await TokenStorage.save(user.token!);
    return user;
  }

  Future<void> forgotPassword({required String email}) async {
    await _dio.post(ApiConstants.forgotPassword, data: {'email': email});
  }

  Future<UserModel> getCurrentUser() async {
    final response = await _dio.get(ApiConstants.me);
    return UserModel.fromProfileJson(response.data);
  }
}
