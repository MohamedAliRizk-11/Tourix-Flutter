import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/discover_service.dart';
import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final DiscoverService _service;

  DiscoverCubit({DiscoverService? service})
    : _service = service ?? DiscoverService(),
      super(DiscoverLoading());

  Future<void> loadDiscoverData() async {
    emit(DiscoverLoading());
    try {
      final places = await _service.getDestinations();
      if (places.isEmpty) {
        emit(const DiscoverError('لا توجد أماكن متاحة حاليًا'));
        return;
      }

      final categories = places
          .map((p) => p.category)
          .whereType<String>()
          .toSet()
          .toList();

      final defaultCategory = categories.isNotEmpty ? categories.first : '';

      emit(
        DiscoverLoaded(
          destinationOfTheDay: places.first,
          allPlaces: places,
          categories: categories,
          selectedCategory: defaultCategory,
          filteredPlaces: places
              .where((p) => p.category == defaultCategory)
              .toList(),
          hiddenGems: places.where((p) => p.tag == 'AI RECOMMENDED').toList(),
        ),
      );
    } catch (e) {
      emit(DiscoverError('تعذر تحميل البيانات: ${e.toString()}'));
    }
  }

  void selectCategory(String category) {
    final current = state;
    if (current is! DiscoverLoaded) return;
    emit(
      current.copyWith(
        selectedCategory: category,
        filteredPlaces: current.allPlaces
            .where((p) => p.category == category)
            .toList(),
      ),
    );
  }
}
