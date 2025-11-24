import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ImagePaletteHelper {
  /// يرجع true لو الصورة غامقة و false لو فاتحة
  static Future<bool> isImageDark(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return true;

    try {
      final imageProvider = NetworkImage(imageUrl);

      // استخدم retry لو حصل timeout أو تحميل الصورة فشل
      final palette = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(200, 100),
        maximumColorCount: 20,
      );

      final dominantColor = palette.dominantColor?.color ?? Colors.black;
      final brightness = ThemeData.estimateBrightnessForColor(dominantColor);

      return brightness == Brightness.dark;
    } catch (e) {
      // fallback
      return true;
    }
  }

  /// يرجع اللون المناسب للـ text/icons حسب الصورة
  static Future<Color> getIconColor(String? imageUrl) async {
    try {
      final dark = await isImageDark(imageUrl);
      return dark ? Colors.white : Colors.black;
    } catch (_) {
      return Colors.white;
    }
  }
}
