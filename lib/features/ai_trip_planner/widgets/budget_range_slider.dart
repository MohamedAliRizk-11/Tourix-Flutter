import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class BudgetRangeSlider extends StatelessWidget {
  final RangeValues values;
  final ValueChanged<RangeValues> onChanged;

  const BudgetRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Estimated Budget', style: AppTextStyles.bodyMedium),
            Text(
              '\$${values.start.toInt()} - \$${values.end.toInt()}',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.primaryGold,
            inactiveTrackColor: AppColors.surfaceLight,
            thumbColor: AppColors.primaryGold,
            overlayColor: AppColors.primaryGold.withValues(alpha: 0.2),
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 9,
            ),
          ),
          child: RangeSlider(
            values: values,
            min: 500,
            max: 10000,
            divisions: 19,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
