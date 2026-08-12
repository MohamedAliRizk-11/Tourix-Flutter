import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/models/quest_model.dart';
import 'mission_state.dart';

class MissionCubit extends Cubit<MissionState> {
  final QuestModel quest;

  MissionCubit({required this.quest}) : super(const MissionInitial());

  Future<void> checkGpsStatus() async {
    emit(const MissionLocating());

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        emit(
          MissionFailed(
            quest: quest,
            message: 'GPS is turned off. Please enable Location.',
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        emit(
          MissionFailed(
            quest: quest,
            message: 'Location permission was denied.',
          ),
        );
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          MissionFailed(
            quest: quest,
            message:
                'Location permission is permanently denied. Open Settings.',
          ),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        quest.latitude,
        quest.longitude,
      );

      emit(
        MissionReady(
          quest: quest,
          distanceMeters: distance,
          accuracyMeters: position.accuracy,
        ),
      );
    } catch (e) {
      emit(
        MissionFailed(
          quest: quest,
          message: 'Unable to get your current location.',
        ),
      );
    }
  }

  Future<void> verifyGps() async {
    emit(MissionVerifying(quest: quest));

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        quest.latitude,
        quest.longitude,
      );

      if (distance <= 100) {
        emit(
          MissionSuccess(
            quest: quest,
            message: 'Location verified successfully.',
          ),
        );
      } else {
        emit(
          MissionFailed(
            quest: quest,
            message:
                'You are ${distance.toStringAsFixed(0)}m away from the location.',
          ),
        );
      }
    } catch (e) {
      emit(
        MissionFailed(quest: quest, message: 'Could not verify your location.'),
      );
    }
  }

  Future<void> verifyQr(String code) async {
    emit(MissionVerifying(quest: quest));

    final normalizedCode = code.trim();

    final validDirectCode = normalizedCode == quest.id;

    final validTourixCode = normalizedCode == 'tourix://quest/${quest.id}';

    if (validDirectCode || validTourixCode) {
      emit(MissionSuccess(quest: quest, message: 'QR verified successfully.'));
    } else {
      emit(
        MissionFailed(
          quest: quest,
          message: 'This QR code does not belong to this mission.',
        ),
      );
    }
  }
}
