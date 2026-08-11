import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../constants/app_spacing.dart';
import '../cubit/avatar_cubit.dart';

class AvatarPickerSheet extends StatelessWidget {
  const AvatarPickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<AvatarCubit>();
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const AvatarPickerSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasAvatar = context.watch<AvatarCubit>().state.avatarPath != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text('Profile Photo', style: AppTextStyles.heading),
            const SizedBox(height: AppSpacing.sm),
            _OptionTile(
              icon: Icons.photo_camera_outlined,
              label: 'Take Photo',
              onTap: () {
                Navigator.pop(context);
                context.read<AvatarCubit>().pickFromCamera();
              },
            ),
            _OptionTile(
              icon: Icons.photo_library_outlined,
              label: 'Choose from Gallery',
              onTap: () {
                Navigator.pop(context);
                context.read<AvatarCubit>().pickFromGallery();
              },
            ),
            if (hasAvatar)
              _OptionTile(
                icon: Icons.delete_outline,
                label: 'Remove Photo',
                iconColor: AppColors.error,
                onTap: () {
                  Navigator.pop(context);
                  context.read<AvatarCubit>().removeAvatar();
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _OptionTile({
    required this.icon,
    required this.label,
    this.iconColor = AppColors.primaryGold,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTextStyles.bodyLarge),
          ],
        ),
      ),
    );
  }
}
