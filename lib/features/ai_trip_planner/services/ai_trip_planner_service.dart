import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../models/destination_option_model.dart';
import '../models/generated_trip_model.dart';
import '../models/trip_preferences.dart';

class AiTripPlannerService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<DestinationOptionModel>> getAvailableDestinations() async {
    final response = await _dio.get(ApiConstants.destinations);
    return (response.data as List)
        .map(
          (e) => DestinationOptionModel(
            id: e['id'] as String,
            name: e['name'] as String,
          ),
        )
        .toList();
  }

  Future<GeneratedTripModel> generateTripRoadmap(
    TripPreferences preferences,
  ) async {
    final response = await _dio.post(
      ApiConstants.generateTrip,
      data: preferences.toJson(),
    );
    return GeneratedTripModel.fromJson(response.data as Map<String, dynamic>);
  }

  static const List<String> travelStyles = [
    'Adventure',
    'Luxury',
    'Culture',
    'Family',
    'Solo',
  ];
  static const List<String> interestsList = [
    'Museums',
    'History',
    'Food',
    'Nature',
    'Photography',
    'Nightlife',
  ];
}
