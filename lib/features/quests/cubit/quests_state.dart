import 'package:equatable/equatable.dart';

import '../../../core/models/quest_model.dart';

abstract class QuestsState extends Equatable {
  const QuestsState();

  @override
  List<Object?> get props => [];
}

class QuestsInitial extends QuestsState {
  const QuestsInitial();
}

class QuestsLoading extends QuestsState {
  const QuestsLoading();
}

class QuestsLoaded extends QuestsState {
  final List<QuestModel> allQuests;
  final List<QuestModel> filteredQuests;
  final List<String> questTypes;
  final String selectedType;

  const QuestsLoaded({
    required this.allQuests,
    required this.filteredQuests,
    required this.questTypes,
    required this.selectedType,
  });

  QuestsLoaded copyWith({
    List<QuestModel>? allQuests,
    List<QuestModel>? filteredQuests,
    List<String>? questTypes,
    String? selectedType,
  }) {
    return QuestsLoaded(
      allQuests: allQuests ?? this.allQuests,
      filteredQuests: filteredQuests ?? this.filteredQuests,
      questTypes: questTypes ?? this.questTypes,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  @override
  List<Object?> get props => [
    allQuests,
    filteredQuests,
    questTypes,
    selectedType,
  ];
}

class QuestsError extends QuestsState {
  final String message;

  const QuestsError({required this.message});

  @override
  List<Object?> get props => [message];
}
