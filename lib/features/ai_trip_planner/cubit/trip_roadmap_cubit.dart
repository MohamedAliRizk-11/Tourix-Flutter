import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/trip_preferences.dart';
import '../services/ai_trip_planner_service.dart';
import 'trip_roadmap_state.dart';

class TripRoadmapCubit extends Cubit<TripRoadmapState> {
  final AiTripPlannerService _service;

  TripRoadmapCubit({AiTripPlannerService? service})
    : _service = service ?? AiTripPlannerService(),
      super(TripRoadmapLoading());

  Future<void> generate(TripPreferences preferences) async {
    emit(TripRoadmapLoading());
    try {
      final trip = await _service.generateTripRoadmap(preferences);
      emit(TripRoadmapLoaded(trip));
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final serverMsg = e.response?.data is Map
          ? e.response?.data['message'] ?? e.response?.data.toString()
          : e.message;
      emit(TripRoadmapError('فشل توليد الخطة (كود $status): $serverMsg'));
    } catch (e) {
      emit(TripRoadmapError('تعذر توليد الخطة: ${e.toString()}'));
    }
  }
}
