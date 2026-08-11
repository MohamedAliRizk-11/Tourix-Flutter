import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/models/quest_model.dart';

class QuestCard extends StatelessWidget {
  final QuestModel quest;
  final VoidCallback onStart;

  const QuestCard({super.key, required this.quest, required this.onStart});

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
                  color: AppColors.accentTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(quest.questType, style: AppTextStyles.labelSmall),
              ),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.primaryGold, size: 14),
              const SizedBox(width: 4),
              Text('${quest.rewardPoints} pts', style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(quest.title, style: AppTextStyles.heading),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.textMuted,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(quest.placeName, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: 6),
          Text(quest.description, style: AppTextStyles.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          PrimaryButton(
            label: 'Start Quest',
            icon: Icons.explore,
            onPressed: onStart,
          ),
        ],
      ),
    );
  }
}
