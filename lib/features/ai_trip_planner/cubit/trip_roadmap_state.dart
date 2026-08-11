import 'package:equatable/equatable.dart';
import '../models/generated_trip_model.dart';

abstract class TripRoadmapState extends Equatable {
  const TripRoadmapState();
  @override
  List<Object?> get props => [];
}

class TripRoadmapLoading extends TripRoadmapState {}

class TripRoadmapLoaded extends TripRoadmapState {
  final GeneratedTripModel trip;
  const TripRoadmapLoaded(this.trip);
  @override
  List<Object?> get props => [trip];
}

class TripRoadmapError extends TripRoadmapState {
  final String message;
  const TripRoadmapError(this.message);
  @override
  List<Object?> get props => [message];
}
