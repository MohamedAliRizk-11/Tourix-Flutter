import 'package:equatable/equatable.dart';
import '../models/destination_option_model.dart';

abstract class AiTripPlannerState extends Equatable {
  const AiTripPlannerState();
  @override
  List<Object?> get props => [];
}

class AiTripPlannerLoading extends AiTripPlannerState {}

class AiTripPlannerLoaded extends AiTripPlannerState {
  final List<DestinationOptionModel> availableDestinations;
  final Set<String> selectedDestinationIds;
  final int days;
  final String selectedTravelStyle;
  final Set<String> selectedInterests;

  const AiTripPlannerLoaded({
    required this.availableDestinations,
    required this.selectedDestinationIds,
    required this.days,
    required this.selectedTravelStyle,
    required this.selectedInterests,
  });

  AiTripPlannerLoaded copyWith({
    Set<String>? selectedDestinationIds,
    int? days,
    String? selectedTravelStyle,
    Set<String>? selectedInterests,
  }) {
    return AiTripPlannerLoaded(
      availableDestinations: availableDestinations,
      selectedDestinationIds:
          selectedDestinationIds ?? this.selectedDestinationIds,
      days: days ?? this.days,
      selectedTravelStyle: selectedTravelStyle ?? this.selectedTravelStyle,
      selectedInterests: selectedInterests ?? this.selectedInterests,
    );
  }

  @override
  List<Object?> get props => [
    availableDestinations,
    selectedDestinationIds,
    days,
    selectedTravelStyle,
    selectedInterests,
  ];
}

class AiTripPlannerError extends AiTripPlannerState {
  final String message;
  const AiTripPlannerError(this.message);
  @override
  List<Object?> get props => [message];
}
