import '../../../core/models/quest_model.dart';

abstract class MissionState {
  const MissionState();
}

class MissionInitial extends MissionState {
  const MissionInitial();
}

class MissionLoading extends MissionState {
  const MissionLoading();
}

class MissionLocating extends MissionState {
  const MissionLocating();
}

class MissionReady extends MissionState {
  final QuestModel quest;
  final double distanceMeters;
  final double accuracyMeters;

  const MissionReady({
    required this.quest,
    required this.distanceMeters,
    required this.accuracyMeters,
  });
}

class MissionVerifying extends MissionState {
  final QuestModel quest;

  const MissionVerifying({required this.quest});
}

class MissionFailed extends MissionState {
  final QuestModel quest;
  final String message;

  const MissionFailed({required this.quest, required this.message});
}

class MissionLoaded extends MissionState {
  final QuestModel quest;

  const MissionLoaded({required this.quest});
}

class MissionSuccess extends MissionState {
  final QuestModel quest;
  final String message;

  const MissionSuccess({required this.quest, required this.message});
}
