import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class DidYouKnowCard extends StatelessWidget {
  final String fact;
  const DidYouKnowCard({super.key, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: AppColors.primaryGold,
            size: 32,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Did you know?',
            style: AppTextStyles.heading.copyWith(color: AppColors.primaryGold),
          ),
          const SizedBox(height: 8),
          Text(
            fact,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
