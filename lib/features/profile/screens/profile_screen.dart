import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/profile/widgets/build_settings_item.dart';
import 'edit_profile_screen.dart';
import 'package:taskify/core/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void changeLanguage() {
    setState(() {
      if (context.locale == const Locale('en')) {
        context.setLocale(const Locale('ar'));
      } else {
        context.setLocale(const Locale('en'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: const AssetImage(
                      "assets/pngs/profile.png",
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'profile_name'.tr(),
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'profile_phone'.tr(),
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black26,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'edit_profile'.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.h),
              Text(
                'profile_settings_section'.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Divider(thickness: 2),
              BuildSettingsItem(
                icon: Icons.language,
                title: 'language'.tr(),
                onTap: changeLanguage,
              ),
              BuildSettingsItem(
                icon: Icons.help_outline,
                title: 'contact_us'.tr(),
                onTap: () {
                  Navigator.pushNamed(context, contactScreenRoute);
                },
              ),
              BuildSettingsItem(
                icon: Icons.info_outline,
                title: 'about_app'.tr(),
                onTap: () {
                  Navigator.pushNamed(context, aboutAppScreenRoute);
                },
              ),
              BuildSettingsItem(
                icon: Icons.description_outlined,
                title: 'terms_conditions'.tr(),
                onTap: () {
                  Navigator.pushNamed(context, termsConditionsScreenRoute);
                },
              ),
              BuildSettingsItem(
                icon: Icons.logout,
                title: 'logout'.tr(),
                onTap: () {},
              ),
              // Optionally: visually mark logout as important
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
