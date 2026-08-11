import 'package:equatable/equatable.dart';

abstract class MissionState extends Equatable {
  const MissionState();
  @override
  List<Object?> get props => [];
}

class MissionIdle extends MissionState {}

class MissionLocating extends MissionState {}

class MissionReady extends MissionState {
  final double distanceMeters;
  final double accuracyMeters;
  const MissionReady({
    required this.distanceMeters,
    required this.accuracyMeters,
  });
  @override
  List<Object?> get props => [distanceMeters, accuracyMeters];
}

class MissionVerifying extends MissionState {}

class MissionSuccess extends MissionState {
  final int xpEarned;
  final String message;
  const MissionSuccess({required this.xpEarned, required this.message});
  @override
  List<Object?> get props => [xpEarned, message];
}

class MissionFailed extends MissionState {
  final String message;
  const MissionFailed(this.message);
  @override
  List<Object?> get props => [message];
}
