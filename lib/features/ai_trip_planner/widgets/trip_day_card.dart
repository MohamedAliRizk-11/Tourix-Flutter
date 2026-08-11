import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/generated_trip_model.dart';
import 'trip_activity_tile.dart';

class TripDayCard extends StatelessWidget {
  final TripDayModel day;
  const TripDayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryGold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'DAY ${day.day}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.background,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(day.title, style: AppTextStyles.heading)),
            ],
          ),
          const SizedBox(height: 6),
          Text(day.description, style: AppTextStyles.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          ...day.activities.map((a) => TripActivityTile(activity: a)),
        ],
      ),
    );
  }
}
