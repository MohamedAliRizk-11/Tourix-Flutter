import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class OracleWisdomCard extends StatelessWidget {
  final String wisdom;
  const OracleWisdomCard({super.key, required this.wisdom});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accentTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.accentTeal.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.accentTeal,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Oracle Wisdom',
                style: AppTextStyles.heading.copyWith(
                  color: AppColors.accentTeal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(wisdom, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
