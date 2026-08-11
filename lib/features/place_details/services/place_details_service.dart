import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../models/place_detail_model.dart';

class PlaceDetailsService {
  final Dio _dio = DioClient.instance.dio;

  Future<PlaceDetailModel> getPlaceDetail(String placeId) async {
    final response = await _dio.get('${ApiConstants.placeDetails}/$placeId');
    return PlaceDetailModel.fromJson(response.data as Map<String, dynamic>);
  }
}
