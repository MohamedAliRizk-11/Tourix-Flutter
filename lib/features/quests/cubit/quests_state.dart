import 'package:equatable/equatable.dart';
import '../../../core/models/quest_model.dart';

abstract class QuestsState extends Equatable {
  const QuestsState();
  @override
  List<Object?> get props => [];
}

class QuestsLoading extends QuestsState {}

class QuestsLoaded extends QuestsState {
  final List<QuestModel> allQuests;
  final List<String> questTypes;
  final String selectedType;
  final List<QuestModel> filteredQuests;

  const QuestsLoaded({
    required this.allQuests,
    required this.questTypes,
    required this.selectedType,
    required this.filteredQuests,
  });

  QuestsLoaded copyWith({
    String? selectedType,
    List<QuestModel>? filteredQuests,
  }) {
    return QuestsLoaded(
      allQuests: allQuests,
      questTypes: questTypes,
      selectedType: selectedType ?? this.selectedType,
      filteredQuests: filteredQuests ?? this.filteredQuests,
    );
  }

  @override
  List<Object?> get props => [
    allQuests,
    questTypes,
    selectedType,
    filteredQuests,
  ];
}

class QuestsError extends QuestsState {
  final String message;
  const QuestsError(this.message);
  @override
  List<Object?> get props => [message];
}
