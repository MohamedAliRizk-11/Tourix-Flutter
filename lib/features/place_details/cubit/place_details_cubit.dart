import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/place_details_service.dart';
import 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceDetailsService _service;

  PlaceDetailsCubit({PlaceDetailsService? service})
    : _service = service ?? PlaceDetailsService(),
      super(PlaceDetailsLoading());

  Future<void> loadDetail(String placeId) async {
    emit(PlaceDetailsLoading());
    try {
      final detail = await _service.getPlaceDetail(placeId);
      emit(PlaceDetailsLoaded(detail));
    } catch (_) {
      emit(const PlaceDetailsError('تعذر تحميل تفاصيل المكان، حاول تاني'));
    }
  }
}
