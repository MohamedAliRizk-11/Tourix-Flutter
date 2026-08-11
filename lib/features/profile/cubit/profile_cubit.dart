import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _service;
  ProfileCubit({ProfileService? service})
    : _service = service ?? ProfileService(),
      super(ProfileLoading());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await _service.getProfile();
      emit(ProfileLoaded(profile));
    } catch (_) {
      emit(const ProfileError('تعذر تحميل الملف الشخصي'));
    }
  }
}
