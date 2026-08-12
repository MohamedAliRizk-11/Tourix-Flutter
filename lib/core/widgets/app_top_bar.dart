import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_spacing.dart';
import 'user_avatar.dart';
import 'avatar_picker_sheet.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? greeting;
  final String? subGreeting;
  final VoidCallback? onNotificationTap;
  final bool showBackButton;

  const AppTopBar({
    super.key,
    this.greeting,
    this.subGreeting,
    this.onNotificationTap,
    this.showBackButton = false,
  });

  Future<void> _openAvatarPicker(BuildContext context) async {
    await AvatarPickerSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            if (showBackButton)
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                ),
              )
            else
              UserAvatar(radius: 20, onTap: () => _openAvatarPicker(context)),

            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: greeting != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greeting!, style: AppTextStyles.heading),
                        if (subGreeting != null)
                          Text(subGreeting!, style: AppTextStyles.bodyMedium),
                      ],
                    )
                  : Text(
                      'Tourix',
                      style: AppTextStyles.displayMedium,
                      textAlign: TextAlign.center,
                    ),
            ),

            IconButton(
              onPressed: onNotificationTap,
              icon: const Icon(
                Icons.notifications_none,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
