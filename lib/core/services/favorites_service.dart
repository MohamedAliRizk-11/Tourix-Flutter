import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';
import '../models/place_model.dart';
import 'dio_client.dart';

class FavoritesService {
  final Dio _dio = DioClient.instance.dio;
  static const _prefsKey = 'favorite_places';

  Future<List<PlaceModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];
    return raw.map((e) => PlaceModel.fromJson(jsonDecode(e))).toList();
  }

  Future<void> addFavorite(PlaceModel place) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];
    raw.removeWhere((e) => (jsonDecode(e)['id'] as String) == place.id);
    raw.add(jsonEncode(place.toJson()));
    await prefs.setStringList(_prefsKey, raw);

    try {
      await _dio.post('${ApiConstants.savedPlaces}/${place.id}');
    } catch (_) {}
  }

  Future<void> removeFavorite(String placeId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_prefsKey) ?? [];
    raw.removeWhere((e) => (jsonDecode(e)['id'] as String) == placeId);
    await prefs.setStringList(_prefsKey, raw);
  }
}
