import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/data/login_repo.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';
import 'package:taskify/services/validator_service.dart';

class AuthLogin extends StatefulWidget {
   AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
    final formkey = GlobalKey<FormState>();
    bool _submitted = false; 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final emailValidator = EmailValidator();
    final passwordValidator = PasswordValidator();

    String? email, password;
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
                    autovalidateMode: _submitted
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          labelText: 'email'.tr(),
                          prefixIcon: Icons.email,
                          onChanged: (value) {
                            email = value;
                          },
                          validator: emailValidator.validate,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          labelText: "password".tr(),
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          onChanged: (value) {
                            password = value;
                          },
                          validator: passwordValidator.validate,
                        ),
                        SizedBox(height: 10.h),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: GestureDetector(
                            onTap: () {},
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
                          onPressed: () async {
                              setState(() => _submitted = true);
                            if (formkey.currentState!.validate()) {
                            try {
                              final data = await LoginRepo().login(
                                email: email!,
                                password: password!,
                              );

                              if (data == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'User not found in profile table',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final role = data['role'] ?? 'User';

                              if (role == 'User') {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  layoutScreenRoute,
                                  (route) => false,
                                  arguments: 'User',
                                );
                              } else {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  layoutScreenRoute,
                                  (route) => false,
                                  arguments: 'Technician',
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login failed: $e')),
                              );
                            }
                          }}
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
