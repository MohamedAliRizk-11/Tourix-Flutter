import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/models/place_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';

class TrendingJourneyCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;

  const TrendingJourneyCard({
    super.key,
    required this.place,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              child: CachedNetworkImage(
                imageUrl: place.imageUrl,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) =>
                    Container(color: AppColors.surface, height: 130),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: Text(
                    place.name,
                    style: AppTextStyles.bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (place.rating != null) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.star,
                    color: AppColors.primaryGold,
                    size: 14,
                  ),
                  Text(' ${place.rating}', style: AppTextStyles.bodySmall),
                ],
              ],
            ),
            if (place.distanceKm != null)
              Text(
                '${place.distanceKm!.toInt()} km from Cairo',
                style: AppTextStyles.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
