import 'package:flutter/material.dart';

import '../../../core/models/quest_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class QuestCard extends StatelessWidget {
  final QuestModel quest;
  final VoidCallback onStart;

  const QuestCard({super.key, required this.quest, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10231D),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF073E3B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  quest.questType,
                  style: const TextStyle(
                    color: Color(0xFF36D8D0),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, size: 17, color: Color(0xFFFFD166)),
              const SizedBox(width: 4),
              Text(
                '${quest.rewardPoints} pts',
                style: const TextStyle(color: Color(0xFF9E9A8F), fontSize: 12),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Text(
            quest.title,
            style: AppTextStyles.displayMedium.copyWith(fontSize: 20),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 15,
                color: Color(0xFF9E9A8F),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  quest.placeName,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            quest.description,
            style: AppTextStyles.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD166),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Quest',
                    style:
                        theme.textTheme.labelLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ) ??
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.explore, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
