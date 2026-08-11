import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../cubit/avatar_cubit.dart';
import '../cubit/avatar_state.dart';

class UserAvatar extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;
  final String? fallbackNetworkUrl;

  const UserAvatar({
    super.key,
    this.radius = 20,
    this.onTap,
    this.fallbackNetworkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvatarCubit, AvatarState>(
      builder: (context, state) {
        ImageProvider? image;
        if (state.avatarPath != null) {
          image = FileImage(File(state.avatarPath!));
        } else if (fallbackNetworkUrl != null &&
            fallbackNetworkUrl!.isNotEmpty) {
          image = CachedNetworkImageProvider(fallbackNetworkUrl!);
        }

        final avatar = CircleAvatar(
          radius: radius,
          backgroundColor: AppColors.surfaceLight,
          backgroundImage: image,
          child: image == null
              ? Icon(Icons.person, color: AppColors.textMuted, size: radius)
              : null,
        );

        if (onTap == null) return avatar;

        return GestureDetector(
          onTap: onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,

              if (radius >= 30)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.background,
                      size: radius * 0.35,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
