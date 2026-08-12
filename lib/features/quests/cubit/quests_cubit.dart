import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/quest_model.dart';
import '../services/quests_service.dart';
import 'quests_state.dart';

class QuestsCubit extends Cubit<QuestsState> {
  final QuestsService _service;

  QuestsCubit({QuestsService? service})
    : _service = service ?? QuestsService(),
      super(const QuestsInitial());

  Future<void> loadQuests() async {
    emit(const QuestsLoading());

    try {
      final List<QuestModel> quests = await _service.getQuests();

      final List<String> types = [
        'All',
        ...quests
            .map((quest) => quest.questType)
            .where((type) => type.isNotEmpty)
            .toSet(),
      ];

      emit(
        QuestsLoaded(
          allQuests: quests,
          filteredQuests: quests,
          questTypes: types,
          selectedType: 'All',
        ),
      );
    } catch (e) {
      emit(QuestsError(message: e.toString()));
    }
  }

  void selectType(String type) {
    if (state is! QuestsLoaded) {
      return;
    }

    final current = state as QuestsLoaded;

    final List<QuestModel> filtered;

    if (type == 'All') {
      filtered = current.allQuests;
    } else {
      filtered = current.allQuests
          .where((quest) => quest.questType == type)
          .toList();
    }

    emit(current.copyWith(selectedType: type, filteredQuests: filtered));
  }
}
