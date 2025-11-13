import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';

import '../../../core/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'edit_profile'.tr(),
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 22.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        image: DecorationImage(
                          image: const AssetImage('assets/pngs/profile.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 3.w,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Material(
                        shape: const CircleBorder(),
                        color: AppColors.primaryColor,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          onTap: () {
                            // TODO: Implement change avatar
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'profile_name'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'profile_phone'.tr(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            Text(
              'edit_profile_subtitle'.tr(),
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
            Divider(thickness: 1.2),
            SizedBox(height: 18.h),
            // Username
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 18.h),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                    ),
                    labelText: 'username'.tr(),
                    hintText: 'enter_new_username'.tr(),
                    border: InputBorder.none,
                  ),
                  validator:
                      (str) => (str == null || str.isEmpty) ? 'Required' : null,
                ),
              ),
            ),
            // Phone
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 18.h),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColors.primaryColor,
                    ),
                    labelText: 'phone_number'.tr(),
                    hintText: 'enter_new_phone_number'.tr(),
                    border: InputBorder.none,
                  ),
                  validator:
                      (str) => (str == null || str.isEmpty) ? 'Required' : null,
                ),
              ),
            ),
            // Password
            Card(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 18.h),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryColor,
                    ),
                    labelText: 'password'.tr(),
                    hintText: 'enter_new_password'.tr(),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 5,
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  shadowColor: AppColors.primaryColor.withOpacity(0.4),
                ),
                onPressed: () {
                  // Example validation
                  if (usernameController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please complete all required fields.'),
                      ),
                    );
                    return;
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                    (route) => false,
                  );
                },
                child: Text(
                  'save_changes'.tr(),
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
