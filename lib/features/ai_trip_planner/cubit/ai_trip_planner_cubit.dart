import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/ai_trip_planner_service.dart';
import 'ai_trip_planner_state.dart';

class AiTripPlannerCubit extends Cubit<AiTripPlannerState> {
  final AiTripPlannerService _service;

  AiTripPlannerCubit({AiTripPlannerService? service})
    : _service = service ?? AiTripPlannerService(),
      super(AiTripPlannerLoading());

  Future<void> loadDestinations() async {
    emit(AiTripPlannerLoading());
    try {
      final destinations = await _service.getAvailableDestinations();
      emit(
        AiTripPlannerLoaded(
          availableDestinations: destinations,
          selectedDestinationIds: const {},
          days: 3,
          selectedTravelStyle: AiTripPlannerService.travelStyles.first,
          selectedInterests: const {},
        ),
      );
    } catch (_) {
      emit(const AiTripPlannerError('تعذر تحميل الوجهات المتاحة، حاول تاني'));
    }
  }

  void toggleDestination(String id) {
    final current = state;
    if (current is! AiTripPlannerLoaded) return;
    final updated = {...current.selectedDestinationIds};
    updated.contains(id) ? updated.remove(id) : updated.add(id);
    emit(current.copyWith(selectedDestinationIds: updated));
  }

  void setDays(int days) {
    final current = state;
    if (current is! AiTripPlannerLoaded || days < 1) return;
    emit(current.copyWith(days: days));
  }

  void selectTravelStyle(String style) {
    final current = state;
    if (current is! AiTripPlannerLoaded) return;
    emit(current.copyWith(selectedTravelStyle: style));
  }

  void toggleInterest(String interest) {
    final current = state;
    if (current is! AiTripPlannerLoaded) return;
    final updated = {...current.selectedInterests};
    updated.contains(interest)
        ? updated.remove(interest)
        : updated.add(interest);
    emit(current.copyWith(selectedInterests: updated));
  }
}
