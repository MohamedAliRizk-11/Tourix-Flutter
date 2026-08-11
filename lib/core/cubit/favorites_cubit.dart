import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/place_model.dart';
import '../services/favorites_service.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesService _service;

  FavoritesCubit({FavoritesService? service})
    : _service = service ?? FavoritesService(),
      super(const FavoritesState(places: []));

  Future<void> loadFavorites() async {
    emit(FavoritesState(places: state.places, isLoading: true));
    final places = await _service.getFavorites();
    emit(FavoritesState(places: places));
  }

  Future<void> toggleFavorite(PlaceModel place) async {
    if (state.isFavorite(place.id)) {
      await _service.removeFavorite(place.id);
      emit(
        FavoritesState(
          places: state.places.where((p) => p.id != place.id).toList(),
        ),
      );
    } else {
      await _service.addFavorite(place);
      emit(FavoritesState(places: [...state.places, place]));
    }
  }
}
