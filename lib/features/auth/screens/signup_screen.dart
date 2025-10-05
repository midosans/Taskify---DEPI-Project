import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/widgets/custom_TextFormField.dart';
import 'package:taskify/features/auth/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_hyper_link.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(),
              const SizedBox(height: 20),
              const PageHeading(title: 'Sign Up'),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),

                child: Form(
                  child: Column(
                    children: [
                      CustomTextformfield(
                        labelText: 'Email',
                        prefixIconPath: 'assets/svgs/email.svg',
                      ),

                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        labelText: 'Password',
                        prefixIconPath: 'assets/svgs/password.svg',
                        isObscureText: true,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextformfield(
                        labelText: 'Confirm Password',
                        prefixIconPath: 'assets/svgs/password.svg',
                        isObscureText: true,
                      ),

                      SizedBox(height: 15.h),

                      CustomButton(
                        text: "Next",
                        size: Size(size.width.w, 48.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.whiteTextColor,
                        onPressed: () {},
                      ),

                      SizedBox(height: 20.h),

                      CustomHyperLink(
                        title: 'Already have an account? ',
                        link: 'Login',
                        onPressed: () {
                          Navigator.pushNamed(context, loginScreenRoute);
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
