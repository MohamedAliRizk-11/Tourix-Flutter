import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../services/avatar_service.dart';
import 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final AvatarService _service;

  AvatarCubit({AvatarService? service})
    : _service = service ?? AvatarService(),
      super(const AvatarState());

  Future<void> loadAvatar() async {
    emit(const AvatarState(isLoading: true));
    final path = await _service.getSavedAvatarPath();
    emit(AvatarState(avatarPath: path));
  }

  Future<void> pickFromGallery() => _pickAndSet(ImageSource.gallery);
  Future<void> pickFromCamera() => _pickAndSet(ImageSource.camera);

  Future<void> _pickAndSet(ImageSource source) async {
    emit(AvatarState(avatarPath: state.avatarPath, isLoading: true));
    try {
      final path = await _service.pickAndSaveAvatar(source);
      emit(AvatarState(avatarPath: path ?? state.avatarPath));
    } catch (_) {
      emit(AvatarState(avatarPath: state.avatarPath));
    }
  }

  Future<void> removeAvatar() async {
    await _service.removeAvatar();
    emit(const AvatarState());
  }
}
