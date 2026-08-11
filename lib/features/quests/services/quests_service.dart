import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/models/quest_model.dart';

class QuestsService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<QuestModel>> getQuests() async {
    final response = await _dio.get(ApiConstants.quests);
    return (response.data as List).map((e) => QuestModel.fromJson(e)).toList();
  }
}
