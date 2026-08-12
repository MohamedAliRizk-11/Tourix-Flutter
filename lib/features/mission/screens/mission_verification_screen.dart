import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/app_top_bar.dart';
import '../../../core/models/quest_model.dart';
import '../cubit/mission_cubit.dart';
import '../cubit/mission_state.dart';
import '../widgets/gps_radar_view.dart';
import '../widgets/qr_scanner_view.dart';

class MissionVerificationScreen extends StatelessWidget {
  final QuestModel quest;
  const MissionVerificationScreen({super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MissionCubit(quest: quest),
      child: const _MissionView(),
    );
  }
}

class _MissionView extends StatefulWidget {
  const _MissionView();

  @override
  State<_MissionView> createState() => _MissionViewState();
}

class _MissionViewState extends State<_MissionView> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(showBackButton: true),
      body: BlocConsumer<MissionCubit, MissionState>(
        listener: (context, state) {
          if (state is MissionSuccess) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                backgroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                ),
                title: Text('تم التحقق! 🎉', style: AppTextStyles.heading),
                content: Text(
                  '${state.message}\nحصلت على ${state.quest.rewardPoints} نقطة',
                  style: AppTextStyles.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'تمام',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final quest = context.read<MissionCubit>().quest;
          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            children: [
              Text(
                'SECURITY PROTOCOL',
                style: AppTextStyles.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Verify Mission',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayLarge,
              ),
              const SizedBox(height: 4),
              Text(
                quest.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: 'GPS Radar',
                      isSelected: _tabIndex == 0,
                      onTap: () => setState(() => _tabIndex = 0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _TabButton(
                      label: 'QR Scanner',
                      isSelected: _tabIndex == 1,
                      onTap: () => setState(() => _tabIndex = 1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              _tabIndex == 0 ? const GpsRadarView() : const QrScannerView(),
              if (quest.description.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                Text('MISSION BRIEF', style: AppTextStyles.labelSmall),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    quest.description,
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
            ],
          );
        },
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentTeal.withValues(alpha: 0.15)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          border: Border.all(
            color: isSelected ? AppColors.accentTeal : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.accentTeal : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
