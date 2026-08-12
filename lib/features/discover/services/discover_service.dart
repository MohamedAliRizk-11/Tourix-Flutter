import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/models/place_model.dart';

class DiscoverService {
  final Dio _dio = DioClient.instance.dio;

  /* Future<List<PlaceModel>> getDestinations() async {
    final response = await _dio.get(ApiConstants.destinations);
    return (response.data as List)
        .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }*/
  Future<List<PlaceModel>> getDestinations() async {
    print('🚀 Calling: ${ApiConstants.baseUrl}${ApiConstants.destinations}');

    final response = await _dio.get(ApiConstants.destinations);

    print('✅ STATUS: ${response.statusCode}');
    // print('✅ DATA: ${response.data}');

    final places = (response.data as List)
        .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
        .toList();

    print('✅ PLACES COUNT: ${places.length}');
    print('🖼️ FIRST IMAGE URL: ${places.first.imageUrl}');
    return places;
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
