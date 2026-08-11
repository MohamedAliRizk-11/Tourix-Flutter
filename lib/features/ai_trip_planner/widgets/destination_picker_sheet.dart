import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../cubit/ai_trip_planner_cubit.dart';
import '../cubit/ai_trip_planner_state.dart';
import '../models/destination_option_model.dart';

class DestinationPickerSheet extends StatelessWidget {
  final List<DestinationOptionModel> options;
  const DestinationPickerSheet({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      child: SafeArea(
        top: false,
        child: BlocBuilder<AiTripPlannerCubit, AiTripPlannerState>(
          builder: (context, state) {
            if (state is! AiTripPlannerLoaded) return const SizedBox.shrink();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text('Select Destinations', style: AppTextStyles.heading),
                const SizedBox(height: AppSpacing.md),
                ...options.map((option) {
                  final isSelected = state.selectedDestinationIds.contains(
                    option.id,
                  );
                  return GestureDetector(
                    onTap: () => context
                        .read<AiTripPlannerCubit>()
                        .toggleDestination(option.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryGold.withValues(alpha: 0.12)
                            : AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMedium,
                        ),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryGold
                              : AppColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option.name,
                              style: AppTextStyles.bodyLarge,
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? AppColors.primaryGold
                                : AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: AppSpacing.sm),
                PrimaryButton(
                  label: 'Done',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
