import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/app_config.dart';
import '../../../core/services/dio_client.dart';

class VisitVerificationResult {
  final bool success;
  final int xpEarned;
  final String? message;
  const VisitVerificationResult({
    required this.success,
    required this.xpEarned,
    this.message,
  });
}

class MissionService {
  final Dio _dio = DioClient.instance.dio;

  Future<Position> getCurrentPosition() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception('لازم تسمح بصلاحية الموقع عشان تتحقق من زيارتك');
    }
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('فعّل خدمة الموقع (GPS) من إعدادات الجهاز أولًا');
    }
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  double distanceToTargetMeters(
    Position current,
    double targetLat,
    double targetLng,
  ) {
    return Geolocator.distanceBetween(
      current.latitude,
      current.longitude,
      targetLat,
      targetLng,
    );
  }

  Future<VisitVerificationResult> checkInWithGps({
    required String questId,
    required double latitude,
    required double longitude,
  }) async {
    if (AppConfig.useMockApi) {
      await Future.delayed(const Duration(seconds: 2));
      return const VisitVerificationResult(
        success: true,
        xpEarned: 150,
        message: 'تم التحقق من زيارتك بنجاح!',
      );
    }
    final response = await _dio.post(
      ApiConstants.checkIn,
      data: {
        'questId': questId,
        'latitude': latitude,
        'longitude': longitude,
        'method': 'gps',
      },
    );
    return VisitVerificationResult(
      success: response.data['status'] == 'Verified',
      xpEarned: response.data['xpEarned'] as int? ?? 0,
      message: response.data['message'] as String?,
    );
  }

  Future<VisitVerificationResult> checkInWithQr({
    required String questId,
    required String scannedCode,
  }) async {
    if (AppConfig.useMockApi) {
      await Future.delayed(const Duration(seconds: 1));
      return const VisitVerificationResult(
        success: true,
        xpEarned: 150,
        message: 'تم مسح الكود بنجاح!',
      );
    }
    final response = await _dio.post(
      ApiConstants.checkIn,
      data: {'questId': questId, 'qrCode': scannedCode, 'method': 'qr'},
    );
    return VisitVerificationResult(
      success: response.data['status'] == 'Verified',
      xpEarned: response.data['xpEarned'] as int? ?? 0,
      message: response.data['message'] as String?,
    );
  }
}
