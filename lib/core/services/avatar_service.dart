import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// إدارة صورة البروفايل - بتاخد صورة من الجهاز (كاميرا/معرض) وتخزنها محليًا بشكل دائم
/// (مش الكاش المؤقت بتاع image_picker) عشان تفضل موجودة بعد إغلاق التطبيق.
/// لما الباك اند يوفر endpoint لرفع الصور، هنضيف uploadAvatar() هنا بس - الـ Cubit والشاشات مش هيتغيروا.
class AvatarService {
  static const _prefsKey = 'profile_avatar_path';
  final ImagePicker _picker = ImagePicker();

  Future<String?> getSavedAvatarPath() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_prefsKey);
    if (path != null && File(path).existsSync()) return path;
    return null;
  }

  Future<String?> pickAndSaveAvatar(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 800,
      imageQuality: 85,
    );
    if (picked == null) return null; // اليوزر ألغى الاختيار

    final appDir = await getApplicationDocumentsDirectory();
    final savedImage = await File(picked.path).copy(
      '${appDir.path}/profile_avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    await _deleteOldAvatarFile();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, savedImage.path);

    return savedImage.path;
  }

  Future<void> removeAvatar() async {
    await _deleteOldAvatarFile();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }

  Future<void> _deleteOldAvatarFile() async {
    final prefs = await SharedPreferences.getInstance();
    final oldPath = prefs.getString(_prefsKey);
    if (oldPath != null) {
      final oldFile = File(oldPath);
      if (oldFile.existsSync()) await oldFile.delete();
    }
  }
}
