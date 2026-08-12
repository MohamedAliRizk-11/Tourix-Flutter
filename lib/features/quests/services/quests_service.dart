import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/models/quest_model.dart';
import '../../../core/services/dio_client.dart';

class QuestsService {
  final Dio _dio = DioClient.instance.dio;

  Future<List<QuestModel>> getQuests() async {
    final response = await _dio.get(ApiConstants.quests);

    final data = response.data;

    if (data is! List) {
      throw Exception('Invalid quests response');
    }

    return data
        .map(
          (item) => QuestModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }
}
