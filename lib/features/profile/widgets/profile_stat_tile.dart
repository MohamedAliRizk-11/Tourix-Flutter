import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class ProfileStatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileStatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryGold, size: 22),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.displayMedium),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
