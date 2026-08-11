import 'package:equatable/equatable.dart';
import '../models/place_model.dart';

class FavoritesState extends Equatable {
  final List<PlaceModel> places;
  final bool isLoading;

  const FavoritesState({required this.places, this.isLoading = false});

  bool isFavorite(String placeId) => places.any((p) => p.id == placeId);

  @override
  List<Object?> get props => [places, isLoading];
}
