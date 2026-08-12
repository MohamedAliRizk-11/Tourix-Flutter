import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/models/place_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';

class DestinationOfDayCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;

  const DestinationOfDayCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),

          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGold.withValues(alpha: 0.18),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: Stack(
            children: [
              /* CachedNetworkImage(
                imageUrl: place.imageUrl,
                height: 340,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.surface, height: 340),
              ),
*/
              Image.network(
                place.imageUrl,
                height: 340,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 340,
                    color: AppColors.surface,
                    child: const Center(child: Text('Image failed')),
                  );
                },
              ),
              //----------------------------------
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.background.withValues(alpha: 0.5),
                      ],
                      stops: const [0.4, 1],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withValues(alpha: 0.45),
                        border: Border(
                          top: BorderSide(
                            color: AppColors.primaryGold.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accentTeal.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.accentTeal.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                            child: Text(
                              'DESTINATION OF THE DAY',
                              style: AppTextStyles.labelSmall,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(place.name, style: AppTextStyles.displayMedium),
                          const SizedBox(height: 8),
                          if (place.shortDescription != null)
                            Text(
                              '"${place.shortDescription!}"',
                              style: AppTextStyles.bodyMedium,
                            ),
                          const SizedBox(height: AppSpacing.md),
                          PrimaryButton(
                            label: 'Explore Now',
                            icon: Icons.arrow_forward,
                            onPressed: onTap,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
