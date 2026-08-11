import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class TripTipsCard extends StatelessWidget {
  final List<String> tips;
  const TripTipsCard({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accentTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.accentTeal.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: AppColors.accentTeal,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                'Oracle Tips',
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.accentTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.accentTeal,
                    ),
                  ),
                  Expanded(child: Text(tip, style: AppTextStyles.bodyMedium)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
