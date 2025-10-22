import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/custom_TextFormField.dart';
import '../../../core/widgets/custom_button.dart';

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
    final size = MediaQuery.sizeOf(context);
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Form(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 110.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/pngs/Depth 5, Frame 0.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 3.w,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.backgroundColor,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Sophia Carter',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

            Text(
              'username'.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              labelText: 'enter_new_username'.tr(),
              controller: usernameController,
            ),
            SizedBox(height: 30.h),

            Text(
              'phone_number'.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              labelText: 'enter_new_phone_number'.tr(),
              controller: phoneController,
            ),
            SizedBox(height: 30.h),

            Text(
              'password'.tr(),
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              labelText: 'enter_new_password'.tr(),
              controller: passwordController,
              isObscureText: true,
            ),

            SizedBox(height: 60.h),

            CustomButton(
              text: "save_changes".tr(),
              size: Size(size.width.w, 48.h),
              color: AppColors.primaryColor,
              fontColor: AppColors.whiteTextColor,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
