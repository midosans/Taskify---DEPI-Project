import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

/// Reset Password Screen
///
/// This screen allows users to set a new password after they have
/// successfully verified their identity using the OTP code. Users
/// must enter and confirm their new password to complete the reset process.
class ResetPasswordScreen extends StatefulWidget {
  // final String email;
  // final String code;

  const ResetPasswordScreen({
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validatePasswordMatch() {
    return _newPasswordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
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
                  child: PageHeading(title: 'reset_password'.tr()),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            'reset_password_description'.tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.greyTextColor,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        // New password field
                        CustomTextFormField(
                          labelText: 'new_password'.tr(),
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          controller: _newPasswordController,
                        ),
                        SizedBox(height: 10.h),
                        // Confirm password field
                        CustomTextFormField(
                          labelText: 'confirm_password'.tr(),
                          prefixIcon: Icons.lock_outline,
                          isObscureText: true,
                          controller: _confirmPasswordController,
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text: 'reset_password_button'.tr(),
                          size: Size(size.width.w, 48.h),
                          color: AppColors.primaryColor,
                          fontColor: AppColors.whiteTextColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (!_validatePasswordMatch()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'passwords_do_not_match'.tr(),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              // TODO: Implement password reset API call
                              // Show success message and navigate to login
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('password_reset_success'.tr()),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Navigate back to login screen
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                loginScreenRoute,
                                (route) => false,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        // Back to verify code link
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'back_to_verify_code'.tr(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
