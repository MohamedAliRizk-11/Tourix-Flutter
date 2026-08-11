import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../cubit/trip_roadmap_cubit.dart';
import '../cubit/trip_roadmap_state.dart';
import '../models/trip_preferences.dart';
import '../widgets/trip_day_card.dart';
import '../widgets/trip_tips_card.dart';

class TripRoadmapScreen extends StatelessWidget {
  final TripPreferences preferences;
  const TripRoadmapScreen({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripRoadmapCubit()..generate(preferences),
      child: const _TripRoadmapView(),
    );
  }
}

class _TripRoadmapView extends StatelessWidget {
  const _TripRoadmapView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(showBackButton: true),
      body: BlocBuilder<TripRoadmapCubit, TripRoadmapState>(
        builder: (context, state) {
          if (state is TripRoadmapLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: AppColors.accentTeal),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'The Oracle is drafting your journey...',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          }
          if (state is TripRoadmapError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium,
                ),
              ),
            );
          }
          final trip = (state as TripRoadmapLoaded).trip;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              Text(
                trip.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                trip.description,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Text('DURATION', style: AppTextStyles.bodySmall),
                          Text(
                            trip.duration,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          Text('EST. BUDGET', style: AppTextStyles.bodySmall),
                          Text(
                            '${trip.estimatedBudget.toInt()} EGP',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryGold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              ...trip.days.map((day) => TripDayCard(day: day)),
              if (trip.tips.isNotEmpty) TripTipsCard(tips: trip.tips),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}
