import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/services/user_session.dart';
import '../../../core/services/token_storage.dart';
import '../../../core/cubit/favorites_cubit.dart';
import '../../../core/cubit/favorites_state.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_stat_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  Future<void> _logout(BuildContext context) async {
    UserSession.instance.clear();
    await TokenStorage.clear();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.welcome,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is ProfileError)
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          final profile = (state as ProfileLoaded).profile;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 44,
                      backgroundColor: AppColors.surfaceLight,
                      child: Icon(
                        Icons.person,
                        color: AppColors.textMuted,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(profile.name, style: AppTextStyles.displayMedium),
                    Text(profile.email, style: AppTextStyles.bodyMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Level ${profile.level} · ${profile.xp} XP',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: ProfileStatTile(
                      icon: Icons.stars_outlined,
                      label: 'Points',
                      value: '${profile.totalPoints}',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ProfileStatTile(
                      icon: Icons.explore_outlined,
                      label: 'Quests',
                      value: '${profile.activeQuests}',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ProfileStatTile(
                      icon: Icons.bookmark_outline,
                      label: 'Saved',
                      value: '${profile.savedPlaces}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Favorites', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  if (favState.isLoading)
                    return const Center(child: CircularProgressIndicator());
                  if (favState.places.isEmpty) {
                    return Text(
                      'لا يوجد أماكن مفضلة بعد',
                      style: AppTextStyles.bodySmall,
                    );
                  }
                  return Column(
                    children: favState.places
                        .map(
                          (place) => Container(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMedium,
                              ),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RouteNames.placeDetails,
                                    arguments: place.id,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: place.imageUrl,
                                      height: 48,
                                      width: 48,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    place.name,
                                    style: AppTextStyles.bodyLarge,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: AppColors.error,
                                    size: 20,
                                  ),
                                  onPressed: () => context
                                      .read<FavoritesCubit>()
                                      .toggleFavorite(place),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _logout(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusPill,
                      ),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}
