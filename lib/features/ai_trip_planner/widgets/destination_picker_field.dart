import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../cubit/ai_trip_planner_cubit.dart';
import '../models/destination_option_model.dart';
import 'destination_picker_sheet.dart';

class DestinationPickerField extends StatelessWidget {
  final List<DestinationOptionModel> options;
  final Set<String> selectedIds;

  const DestinationPickerField({
    super.key,
    required this.options,
    required this.selectedIds,
  });

  String _displayText() {
    if (selectedIds.isEmpty) return '';
    return options
        .where((o) => selectedIds.contains(o.id))
        .map((o) => o.name)
        .join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final displayText = _displayText();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Destination',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            final cubit = context.read<AiTripPlannerCubit>();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: DestinationPickerSheet(options: options),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textMuted,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    displayText.isEmpty ? 'Where to?' : displayText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: displayText.isEmpty
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textMuted,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
