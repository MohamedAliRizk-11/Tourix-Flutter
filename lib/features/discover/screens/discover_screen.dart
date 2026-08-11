import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/selectable_chip.dart';
import '../cubit/discover_cubit.dart';
import '../cubit/discover_state.dart';
import '../services/discover_service.dart';
import '../widgets/destination_of_day_card.dart';
import '../widgets/trending_journey_card.dart';
import '../widgets/hidden_gem_tile.dart';
import '../widgets/did_you_know_card.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverCubit()..loadDiscoverData(),
      child: const _DiscoverView(),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  const _DiscoverView();

  void _goToPlaceDetails(BuildContext context, String placeId) {
    Navigator.pushNamed(context, RouteNames.placeDetails, arguments: placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(
        greeting: 'Welcome, Traveler',
        subGreeting: 'Good Evening, Explore Egypt',
      ),
      body: BlocBuilder<DiscoverCubit, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is DiscoverError)
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          final loaded = state as DiscoverLoaded;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textMuted),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Find your next ancestral journey...',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ),
                    const Icon(Icons.tune, color: AppColors.textMuted),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              DestinationOfDayCard(
                place: loaded.destinationOfTheDay,
                onTap: () =>
                    _goToPlaceDetails(context, loaded.destinationOfTheDay.id),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Curated Realms', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: loaded.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) {
                    final cat = loaded.categories[i];
                    return SelectableChip(
                      label: cat,
                      isSelected: cat == loaded.selectedCategory,
                      onTap: () =>
                          context.read<DiscoverCubit>().selectCategory(cat),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Trending Journeys', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              SizedBox(
                height: 190,
                child: loaded.filteredPlaces.isEmpty
                    ? Center(
                        child: Text(
                          'لا يوجد أماكن في هذه الفئة حاليًا',
                          style: AppTextStyles.bodySmall,
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: loaded.filteredPlaces.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (_, i) => TrendingJourneyCard(
                          place: loaded.filteredPlaces[i],
                          onTap: () => _goToPlaceDetails(
                            context,
                            loaded.filteredPlaces[i].id,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Hidden Gems', style: AppTextStyles.displayMedium),
              const SizedBox(height: AppSpacing.sm),
              ...loaded.hiddenGems.map(
                (p) => HiddenGemTile(
                  place: p,
                  onTap: () => _goToPlaceDetails(context, p.id),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              DidYouKnowCard(fact: DiscoverService.didYouKnowFact),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}
