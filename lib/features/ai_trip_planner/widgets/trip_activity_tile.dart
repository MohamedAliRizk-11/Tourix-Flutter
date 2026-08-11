import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/generated_trip_model.dart';

class TripActivityTile extends StatelessWidget {
  final TripActivityModel activity;
  const TripActivityTile({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 64,
            child: Text(
              activity.time,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accentTeal,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(activity.description, style: AppTextStyles.bodySmall),
                if (activity.estimatedCost > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '~ ${activity.estimatedCost.toInt()} EGP',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryGold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
