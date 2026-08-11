import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/selectable_chip.dart';
import '../cubit/ai_trip_planner_cubit.dart';
import '../cubit/ai_trip_planner_state.dart';
import '../services/ai_trip_planner_service.dart';
import '../models/trip_preferences.dart';
import '../widgets/destination_picker_field.dart';
import '../widgets/day_counter_field.dart';
import '../widgets/oracle_engine_card.dart';

class AiTripPlannerScreen extends StatelessWidget {
  const AiTripPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiTripPlannerCubit()..loadDestinations(),
      child: const _AiTripPlannerView(),
    );
  }
}

class _AiTripPlannerView extends StatelessWidget {
  const _AiTripPlannerView();

  void _onGeneratePressed(BuildContext context, AiTripPlannerLoaded state) {
    if (state.selectedDestinationIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('اختر مكان واحد على الأقل'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    final selectedNames = state.availableDestinations
        .where((d) => state.selectedDestinationIds.contains(d.id))
        .map((d) => d.name)
        .join(', ');

    final preferences = TripPreferences(
      destination: selectedNames,
      duration: '${state.days} Days',
      travelStyle: state.selectedTravelStyle,
      interests: state.selectedInterests.toList(),
    );

    Navigator.pushNamed(
      context,
      RouteNames.tripRoadmap,
      arguments: preferences,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(),
      body: BlocBuilder<AiTripPlannerCubit, AiTripPlannerState>(
        builder: (context, state) {
          if (state is AiTripPlannerLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is AiTripPlannerError)
            return Center(
              child: Text(state.message, style: AppTextStyles.bodyMedium),
            );
          final loaded = state as AiTripPlannerLoaded;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: AppColors.surface,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentTeal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'AI INTELLIGENCE',
                          style: AppTextStyles.labelSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI Trip Planner',
                        style: AppTextStyles.displayLarge,
                      ),
                      Text(
                        'Generate your perfect Egypt adventure with AI.',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              DestinationPickerField(
                options: loaded.availableDestinations,
                selectedIds: loaded.selectedDestinationIds,
              ),
              const SizedBox(height: AppSpacing.md),
              DayCounterField(
                days: loaded.days,
                onChanged: (d) => context.read<AiTripPlannerCubit>().setDays(d),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Travel Style', style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: AiTripPlannerService.travelStyles.map((style) {
                  return SelectableChip(
                    label: style,
                    isSelected: style == loaded.selectedTravelStyle,
                    onTap: () => context
                        .read<AiTripPlannerCubit>()
                        .selectTravelStyle(style),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Interests', style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: AiTripPlannerService.interestsList.map((interest) {
                  return SelectableChip(
                    label: interest,
                    isSelected: loaded.selectedInterests.contains(interest),
                    onTap: () => context
                        .read<AiTripPlannerCubit>()
                        .toggleInterest(interest),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: 'GENERATE MY TRIP',
                onPressed: () => _onGeneratePressed(context, loaded),
              ),
              const SizedBox(height: AppSpacing.xl),
              const OracleEngineCard(),
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}
