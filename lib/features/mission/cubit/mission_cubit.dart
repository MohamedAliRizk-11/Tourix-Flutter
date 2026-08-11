import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/quest_model.dart';
import '../services/mission_service.dart';
import 'mission_state.dart';

class MissionCubit extends Cubit<MissionState> {
  final MissionService _service;
  final QuestModel quest;

  MissionCubit({required this.quest, MissionService? service})
    : _service = service ?? MissionService(),
      super(MissionIdle());

  Future<void> checkGpsStatus() async {
    if (quest.latitude == null || quest.longitude == null) {
      emit(
        const MissionFailed(
          'إحداثيات هذا المكان غير متوفرة حاليًا - سيتم إضافتها من الباك اند لاحقًا',
        ),
      );
      return;
    }
    emit(MissionLocating());
    try {
      final position = await _service.getCurrentPosition();
      final distance = _service.distanceToTargetMeters(
        position,
        quest.latitude!,
        quest.longitude!,
      );
      emit(
        MissionReady(
          distanceMeters: distance,
          accuracyMeters: position.accuracy,
        ),
      );
    } catch (e) {
      emit(MissionFailed(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> verifyGps() async {
    if (quest.latitude == null || quest.longitude == null) return;
    emit(MissionVerifying());
    try {
      final position = await _service.getCurrentPosition();
      final result = await _service.checkInWithGps(
        questId: quest.id,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      if (result.success) {
        emit(
          MissionSuccess(
            xpEarned: result.xpEarned,
            message: result.message ?? 'تم التحقق بنجاح',
          ),
        );
      } else {
        emit(MissionFailed(result.message ?? 'فشل التحقق، حاول تاني'));
      }
    } catch (e) {
      emit(MissionFailed(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> verifyQr(String scannedCode) async {
    emit(MissionVerifying());
    try {
      final result = await _service.checkInWithQr(
        questId: quest.id,
        scannedCode: scannedCode,
      );
      if (result.success) {
        emit(
          MissionSuccess(
            xpEarned: result.xpEarned,
            message: result.message ?? 'تم التحقق بنجاح',
          ),
        );
      } else {
        emit(MissionFailed(result.message ?? 'الكود غير صحيح، حاول تاني'));
      }
    } catch (_) {
      emit(const MissionFailed('حصل خطأ أثناء التحقق، حاول تاني'));
    }
  }
}
