import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
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
                  child: PageHeading(title: 'login'.tr()),
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: 'email'.tr(),
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          labelText: "password".tr(),
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                forgotPasswordScreenRoute,
                              );
                            },
                            child: Text(
                              'forgot_password'.tr(),
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          text: "login".tr(),
                          size: Size(size.width.w, 48.h),
                          color: AppColors.primaryColor,
                          fontColor: AppColors.whiteTextColor,
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              layoutScreenRoute,
                              (route) => false,
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          text: "sign_up_with_google".tr(),
                          size: Size(size.width.w, 48.h),
                          color: AppColors.secondaryBottomColor,
                          fontColor: AppColors.blackTextColor,
                          iconPath: 'assets/svgs/google.svg',
                        ),
                        SizedBox(height: 100.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('dont_have_account'.tr()),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  userTypeScreenRoute,
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'sign_up_exclamation'.tr(),
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
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
