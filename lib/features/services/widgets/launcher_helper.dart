import 'package:url_launcher/url_launcher.dart';

class LauncherHelper {
  static Future<void> openDialer(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber.trim());

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('تعذر فتح تطبيق الاتصال');
    }
  }
}