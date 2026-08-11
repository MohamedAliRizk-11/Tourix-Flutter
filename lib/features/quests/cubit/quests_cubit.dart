import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/quests_service.dart';
import 'quests_state.dart';

class QuestsCubit extends Cubit<QuestsState> {
  final QuestsService _service;
  QuestsCubit({QuestsService? service})
    : _service = service ?? QuestsService(),
      super(QuestsLoading());

  Future<void> loadQuests() async {
    emit(QuestsLoading());
    try {
      final quests = await _service.getQuests();
      final types = quests.map((q) => q.questType).toSet().toList();
      final defaultType = types.isNotEmpty ? types.first : '';
      emit(
        QuestsLoaded(
          allQuests: quests,
          questTypes: types,
          selectedType: defaultType,
          filteredQuests: quests
              .where((q) => q.questType == defaultType)
              .toList(),
        ),
      );
    } catch (_) {
      emit(const QuestsError('تعذر تحميل المهام، تأكد إن السيرفر شغال'));
    }
  }

  void selectType(String type) {
    final current = state;
    if (current is! QuestsLoaded) return;
    emit(
      current.copyWith(
        selectedType: type,
        filteredQuests: current.allQuests
            .where((q) => q.questType == type)
            .toList(),
      ),
    );
  }
}
