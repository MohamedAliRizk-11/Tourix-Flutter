import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../cubit/mission_cubit.dart';
import '../cubit/mission_state.dart';

class GpsRadarView extends StatefulWidget {
  const GpsRadarView({super.key});

  @override
  State<GpsRadarView> createState() => _GpsRadarViewState();
}

class _GpsRadarViewState extends State<GpsRadarView> {
  @override
  void initState() {
    super.initState();
    context.read<MissionCubit>().checkGpsStatus();
  }

  @override
  Widget build(BuildContext context) {
    final quest = context.read<MissionCubit>().quest;
    return BlocBuilder<MissionCubit, MissionState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: 260,
              height: 260,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accentTeal.withValues(alpha: 0.3),
                ),
              ),
              child: Container(
                width: 180,
                height: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.accentTeal.withValues(alpha: 0.5),
                  ),
                ),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentTeal,
                  ),
                  alignment: Alignment.center,
                  child: state is MissionLocating || state is MissionVerifying
                      ? const CircularProgressIndicator(
                          color: AppColors.background,
                          strokeWidth: 2,
                        )
                      : const Icon(
                          Icons.gps_fixed,
                          color: AppColors.background,
                        ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              state is MissionReady
                  ? 'SIGNAL LOCKED'
                  : (state is MissionFailed ? 'SIGNAL LOST' : 'LOCATING...'),
              style: AppTextStyles.heading.copyWith(
                color: AppColors.accentTeal,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _InfoBox(
                    label: 'DISTANCE',
                    value: state is MissionReady
                        ? '${state.distanceMeters.toInt()}m'
                        : '--',
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _InfoBox(
                    label: 'ACCURACY',
                    value: state is MissionReady
                        ? '${state.accuracyMeters.toInt()}m'
                        : '--',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _InfoBox(
              label: 'LOCATION',
              value: quest.placeName,
              fullWidth: true,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (state is MissionFailed)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Text(
                  state.message,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            PrimaryButton(
              label: 'Verify Location',
              icon: Icons.verified_outlined,
              isLoading: state is MissionVerifying,
              onPressed: state is MissionReady
                  ? () => context.read<MissionCubit>().verifyGps()
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;
  final bool fullWidth;
  const _InfoBox({
    required this.label,
    required this.value,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
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
