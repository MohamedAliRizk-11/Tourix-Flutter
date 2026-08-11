import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../models/map_place_model.dart';

class MapService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<MapPlaceModel>> getMapPlaces() async {
    final response = await _dio.get(ApiConstants.mapPlaces);
    return (response.data as List)
        .map((e) => MapPlaceModel.fromJson(e))
        .toList();
  }
}
