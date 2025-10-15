import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/pngs/logo.png',
                  height: 158.h,
                  width: 158.w,
                ),
                SizedBox(height: 45.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 21.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          labelText: "password",
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          text: "login",
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
                          text: "Sign up with Google",
                          size: Size(size.width.w, 48.h),
                          color: AppColors.secondaryBottomColor,
                          fontColor: AppColors.blackTextColor,
                          iconPath: 'assets/svgs/google.svg',
                        ),
                        SizedBox(height: 50.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Dont have an account? '),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  userTypeScreenRoute,
                                  (route) => false,
                                );
                              },
                              child: Text(
                                'Sign Up!',
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppColors.primaryColor),
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
