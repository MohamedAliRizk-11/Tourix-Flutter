import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/services/user_session.dart';
import '../services/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit({AuthService? authService})
    : _authService = authService ?? AuthService(),
      super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authService.login(email: email, password: password);
      UserSession.instance.setUser(user);
      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailure(_mapError(e)));
    } catch (_) {
      emit(const AuthFailure('حصل خطأ غير متوقع، حاول تاني'));
    }
  }

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signup(
        fullName: fullName,
        email: email,
        password: password,
      );
      UserSession.instance.setUser(user);
      emit(AuthSuccess(user));
    } on DioException catch (e) {
      emit(AuthFailure(_mapError(e)));
    } catch (_) {
      emit(const AuthFailure('حصل خطأ غير متوقع، حاول تاني'));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await _authService.forgotPassword(email: email);
      emit(AuthEmailSent());
    } on DioException catch (e) {
      emit(AuthFailure(_mapError(e)));
    } catch (_) {
      emit(const AuthFailure('حصل خطأ غير متوقع، حاول تاني'));
    }
  }

  String _mapError(DioException e) {
    if (e.response?.data is Map && e.response?.data['message'] != null) {
      return e.response?.data['message'];
    }
    return 'فشل الاتصال بالسيرفر، تأكد من النت وحاول تاني';
  }
}
