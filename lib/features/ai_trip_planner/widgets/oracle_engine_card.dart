import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class OracleEngineCard extends StatelessWidget {
  const OracleEngineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome, color: AppColors.primaryGold),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Oracle Engine v4.2', style: AppTextStyles.displayMedium),
          const SizedBox(height: 6),
          Text(
            'Our AI analyzes over 5,000 data points across the Nile Delta to curate your journey.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                value: '98%',
                label: 'MATCH ACCURACY',
                color: AppColors.primaryGold,
              ),
              _StatItem(
                value: '12s',
                label: 'GEN SPEED',
                color: AppColors.accentTeal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.displayMedium.copyWith(color: color)),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
