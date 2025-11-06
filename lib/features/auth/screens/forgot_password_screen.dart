import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

/// Forgot Password Screen
///
/// This screen allows users to enter their email address to initiate
/// the password reset process. A verification code will be sent to the
/// provided email address for account verification.
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: PageHeading(title: 'forgot_password'.tr()),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          'forgot_password_description'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.greyTextColor,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              labelText: 'email'.tr(),
                              prefixIcon: Icons.email,
                              controller: emailController,
                            ),
                            SizedBox(height: 24.h),
                            CustomButton(
                              text: 'send_verification_code'.tr(),
                              size: Size(size.width.w, 48.h),
                              color: AppColors.primaryColor,
                              fontColor: AppColors.whiteTextColor,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  // Navigate to verify code screen
                                  Navigator.pushNamed(
                                    context,
                                    verifyCodeScreenRoute,
                                    arguments: emailController.text.trim(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 16.h),
                            // Back to login link
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'back_to_login'.tr(),
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
