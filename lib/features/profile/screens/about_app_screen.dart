import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:taskify/core/app_colors.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = AppColors.primaryColor;
    final backgroundColor = AppColors.backgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        title: Text(
          'about_app'.tr(),
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
          child: Card(
            elevation: 6,
            shadowColor: accentColor.withOpacity(0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28.0,
                vertical: 32.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Icon
                  CircleAvatar(
                    backgroundColor: accentColor.withOpacity(0.12),
                    radius: 50,
                    child: Image.asset(
                      'assets/pngs/logo.png',
                      width: 62,
                      height: 62,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // App Name
                  Text(
                    'Taskify',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Your Home Service Partner',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.lightFontColor,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 26),
                  // About Description
                  Text(
                    'about_app_desc'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.blackTextColor,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Divider and app version/info
                  Divider(thickness: 1.4, color: AppColors.lightGreyColor),
                  const SizedBox(height: 10),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
