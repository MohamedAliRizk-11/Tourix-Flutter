import 'package:equatable/equatable.dart';
import '../models/map_place_model.dart';

abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object?> get props => [];
}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<MapPlaceModel> places;
  const MapLoaded({required this.places});
  @override
  List<Object?> get props => [places];
}

class MapError extends MapState {
  final String message;
  const MapError(this.message);
  @override
  List<Object?> get props => [message];
}
