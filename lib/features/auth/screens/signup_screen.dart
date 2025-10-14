import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/widgets/custom_TextFormField.dart';
import 'package:taskify/features/auth/widgets/custom_button.dart';
import 'package:taskify/features/auth/widgets/custom_hyper_link.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole;
  final List<String> roles = [
    'AC Technician',
    'Plumber',
    'Electrician',
    'TV Repair',
    'Carpenter',
    'Painter',
    'Cleaner',
    'Mechanic',
    'Glass Worker',
    'Internet Technician',
    'Satellite Technician',
  ];

  @override
  Widget build(BuildContext context) {
    final String? userType =
        ModalRoute.of(context)!.settings.arguments as String?;

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
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
                    CustomTextFormField(
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      labelText: 'Email',
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      isObscureText: true,
                    ),
                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 10.h),

                    if (userType == 'Technician') ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedRole,
                            hint: const Text(
                              'Select Role',
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items:
                                roles.map((String role) {
                                  return DropdownMenuItem<String>(
                                    value: role,
                                    child: Text(
                                      role,
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRole = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],

                    SizedBox(height: 10.h),

                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          layoutScreenRoute,
                          (route) => false,
                        );
                      },
                      text: "Sign Up",
                      size: Size(size.width.w, 48.h),
                      color: AppColors.primaryColor,
                      fontColor: AppColors.whiteTextColor,
                    ),
                    SizedBox(height: 20.h),
                    CustomHyperLink(
                      title: 'Already have an account? ',
                      link: 'Login',
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          loginScreenRoute,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
