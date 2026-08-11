import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit()..loadMapData(),
      child: const _MapView(),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();
  static const _initialPosition = CameraPosition(
    target: LatLng(26.8206, 30.8025),
    zoom: 5.7,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is MapError)
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          final loaded = state as MapLoaded;

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _initialPosition,
                markers: loaded.places.map((p) {
                  return Marker(
                    markerId: MarkerId(p.id),
                    position: LatLng(p.latitude, p.longitude),
                    infoWindow: InfoWindow(title: p.name, snippet: p.city),
                    onTap: () => Navigator.pushNamed(
                      context,
                      RouteNames.placeDetails,
                      arguments: p.id,
                    ),
                  );
                }).toSet(),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusPill,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text("Oracle's Map", style: AppTextStyles.heading),
                        const Spacer(),
                        const Icon(
                          Icons.notifications_none,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
