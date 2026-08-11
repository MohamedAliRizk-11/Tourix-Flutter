import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final VideoPlayerController _controller;
  bool _hasNavigated = false;

  static const Duration _splashDuration = Duration(seconds: 11);

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/tourix.mp4')
      ..initialize().then((_) {
        if (!mounted) return;

        setState(() {});

        _controller
          ..setLooping(true)
          ..play();
      });

    Future.delayed(_splashDuration, _navigateToWelcome);
  }

  void _navigateToWelcome() {
    if (_hasNavigated || !mounted) return;

    _hasNavigated = true;
    Navigator.pushReplacementNamed(context, RouteNames.welcome);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          else
            const SizedBox.shrink(),

          Positioned(
            bottom: AppSpacing.xl,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: GestureDetector(
                  onTap: _navigateToWelcome,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusPill,
                      ),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Skip',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
