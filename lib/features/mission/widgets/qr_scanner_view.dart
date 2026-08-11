import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../cubit/mission_cubit.dart';
import '../cubit/mission_state.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView> {
  bool _hasScanned = false;

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    final code = capture.barcodes.first.rawValue;
    if (code == null) return;
    _hasScanned = true;
    context.read<MissionCubit>().verifyQr(code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionCubit, MissionState>(
      builder: (context, state) {
        return Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              child: SizedBox(
                height: 320,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    MobileScanner(onDetect: _onDetect),
                    if (state is MissionVerifying)
                      Container(
                        color: AppColors.background.withValues(alpha: 0.6),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.accentTeal,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'وجّه الكاميرا تجاه رمز QR الموجود عند المعلم',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium,
            ),
            if (state is MissionFailed) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                state.message,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
              ),
              TextButton(
                onPressed: () => setState(() => _hasScanned = false),
                child: Text(
                  'حاول تاني',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.accentTeal,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
