import 'package:equatable/equatable.dart';
import '../models/place_detail_model.dart';

abstract class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();
  @override
  List<Object?> get props => [];
}

class PlaceDetailsLoading extends PlaceDetailsState {}

class PlaceDetailsLoaded extends PlaceDetailsState {
  final PlaceDetailModel detail;
  const PlaceDetailsLoaded(this.detail);
  @override
  List<Object?> get props => [detail];
}

class PlaceDetailsError extends PlaceDetailsState {
  final String message;
  const PlaceDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}
