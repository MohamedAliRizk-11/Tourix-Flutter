import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/models/place_model.dart';
import '../../../core/cubit/favorites_cubit.dart';
import '../../../core/cubit/favorites_state.dart';
import '../cubit/place_details_cubit.dart';
import '../cubit/place_details_state.dart';
import '../models/place_detail_model.dart';
import '../widgets/place_hero_media.dart';
import '../widgets/oracle_wisdom_card.dart';
import '../widgets/info_chip.dart';
import '../widgets/nearby_discovery_tile.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final String placeId;
  const PlaceDetailsScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceDetailsCubit()..loadDetail(placeId),
      child: const _PlaceDetailsView(),
    );
  }
}

class _PlaceDetailsView extends StatelessWidget {
  const _PlaceDetailsView();

  PlaceModel _toPlaceModel(PlaceDetailModel detail) {
    return PlaceModel(
      id: detail.id,
      name: detail.name,
      location: detail.location,
      imageUrl: detail.heroImageUrl,
      rating: detail.rating,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (context, state) {
          if (state is PlaceDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlaceDetailsError) {
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          }
          final detail = (state as PlaceDetailsLoaded).detail;
          final placeModel = _toPlaceModel(detail);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 340,
                backgroundColor: AppColors.background,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _CircleIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, favState) {
                        final isFav = favState.isFavorite(placeModel.id);
                        return _CircleIconButton(
                          icon: isFav ? Icons.favorite : Icons.favorite_border,
                          iconColor: isFav
                              ? AppColors.error
                              : AppColors.textPrimary,
                          onTap: () => context
                              .read<FavoritesCubit>()
                              .toggleFavorite(placeModel),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                    child: _CircleIconButton(icon: Icons.share, onTap: () {}),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: PlaceHeroMedia(
                    imageUrl: detail.heroImageUrl,
                    videoUrl: detail.heroVideoUrl,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primaryGold,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            detail.location.toUpperCase(),
                            style: AppTextStyles.labelSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(detail.name, style: AppTextStyles.displayLarge),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.primaryGold,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${detail.rating}/5',
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.account_balance_wallet_outlined,
                                  color: AppColors.textMuted,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  detail.priceLabel,
                                  style: AppTextStyles.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      Text(detail.sectionTitle, style: AppTextStyles.heading),
                      const SizedBox(height: 8),
                      Text(detail.description, style: AppTextStyles.bodyMedium),
                      const SizedBox(height: AppSpacing.lg),

                      OracleWisdomCard(wisdom: detail.oracleWisdom),
                      const SizedBox(height: AppSpacing.md),

                      Row(
                        children: [
                          InfoChip(
                            icon: Icons.access_time,
                            label: 'Opening Hours',
                            value: detail.openingHours,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          InfoChip(
                            icon: Icons.wb_twilight,
                            label: 'Best Time',
                            value: detail.bestTime,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      if (detail.nearbyPlaces.isNotEmpty) ...[
                        Text(
                          'NEARBY DISCOVERIES',
                          style: AppTextStyles.labelSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ...detail.nearbyPlaces.map(
                          (p) => NearbyDiscoveryTile(
                            place: p,
                            onTap: () => Navigator.pushReplacementNamed(
                              context,
                              RouteNames.placeDetails,
                              arguments: p.id,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                      ],

                      PrimaryButton(
                        label: 'Start Quest',
                        icon: Icons.explore,
                        onPressed: () {},
                      ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
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

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  const _CircleIconButton({
    required this.icon,
    this.iconColor = AppColors.textPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.6),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}
