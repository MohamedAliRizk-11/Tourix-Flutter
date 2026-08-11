import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/models/place_model.dart';

class DiscoverService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<PlaceModel>> getDestinations() async {
    final response = await _dio.get(ApiConstants.destinations);
    return (response.data as List)
        .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static const List<String> categories = [
    'Historical',
    'Museum',
    'Entertainment',
    'Cultural',
  ];

  static const String didYouKnowFact =
      'The Great Pyramid of Giza was the tallest man-made structure in the world for over 3,800 years.';
}
