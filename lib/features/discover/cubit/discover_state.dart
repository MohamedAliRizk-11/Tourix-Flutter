import 'package:equatable/equatable.dart';
import '../../../core/models/place_model.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();
  @override
  List<Object?> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  final PlaceModel destinationOfTheDay;
  final List<PlaceModel> allPlaces;
  final List<String> categories; // بقت جاية من الداتا الحقيقية مش ثابتة
  final String selectedCategory;
  final List<PlaceModel> filteredPlaces;
  final List<PlaceModel> hiddenGems;

  const DiscoverLoaded({
    required this.destinationOfTheDay,
    required this.allPlaces,
    required this.categories,
    required this.selectedCategory,
    required this.filteredPlaces,
    required this.hiddenGems,
  });

  DiscoverLoaded copyWith({
    String? selectedCategory,
    List<PlaceModel>? filteredPlaces,
  }) {
    return DiscoverLoaded(
      destinationOfTheDay: destinationOfTheDay,
      allPlaces: allPlaces,
      categories: categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      filteredPlaces: filteredPlaces ?? this.filteredPlaces,
      hiddenGems: hiddenGems,
    );
  }

  @override
  List<Object?> get props => [
    destinationOfTheDay,
    allPlaces,
    categories,
    selectedCategory,
    filteredPlaces,
    hiddenGems,
  ];
}

class DiscoverError extends DiscoverState {
  final String message;
  const DiscoverError(this.message);
  @override
  List<Object?> get props => [message];
}
