import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/map_service.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapService _service;
  MapCubit({MapService? service})
    : _service = service ?? MapService(),
      super(MapLoading());

  Future<void> loadMapData() async {
    emit(MapLoading());
    try {
      final places = await _service.getMapPlaces();
      emit(MapLoaded(places: places));
    } catch (_) {
      emit(const MapError('تعذر تحميل بيانات الخريطة، تأكد إن السيرفر شغال'));
    }
  }
}
