import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../models/quest_objective_model.dart';

class CurrentObjectiveCard extends StatelessWidget {
  final QuestObjectiveModel objective;
  final VoidCallback onStartQuest;

  const CurrentObjectiveCard({
    super.key,
    required this.objective,
    required this.onStartQuest,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.primaryGold,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text('CURRENT OBJECTIVE', style: AppTextStyles.labelSmall),
            ],
          ),
          const SizedBox(height: 4),
          Text(objective.title, style: AppTextStyles.displayMedium),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.textMuted,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(objective.location, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _StatBox(
                  icon: Icons.directions_walk,
                  label: 'DISTANCE',
                  value: '${objective.distanceKm} km',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _StatBox(
                  icon: Icons.access_time,
                  label: 'EST. TIME',
                  value: '${objective.estMinutes} mins',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            label: 'START QUEST',
            icon: Icons.play_arrow,
            onPressed: onStartQuest,
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.textMuted, size: 12),
              const SizedBox(width: 4),
              Text(label, style: AppTextStyles.bodySmall),
            ],
          ),
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
