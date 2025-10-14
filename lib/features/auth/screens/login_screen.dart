import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/widgets/custom_TextFormField.dart';
import 'package:taskify/features/auth/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_hyper_link.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

class AuthLogin extends StatelessWidget {
  const AuthLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PageHeader(),
              const SizedBox(height: 20),
              const PageHeading(title: 'Login'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextformfield(
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        isObscureText: true,
                      ),
                      SizedBox(height: 10.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      CustomButton(
                        text: "login",
                        size: Size(size.width.w, 48.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.whiteTextColor,
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            layoutScreenRoute,
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
                      SizedBox(height: 30.h),

                      CustomHyperLink(
                        title: 'Already have an account? ',
                        link: 'sign Up',
                        onPressed: () {
                          Navigator.pushNamed(context, userTypeScreenRoute);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//Size(size.width, 50)