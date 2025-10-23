import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
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
    'ac_technician',
    'plumber',
    'electrician',
    'carpenter',
    'painter',
    'tv_repair',
    'cleaner',
    'mechanic',
    'glass_worker',
    'internet_technician',
    'satellite_technician',
  ];

  @override
  Widget build(BuildContext context) {
    final String? userType =
        ModalRoute.of(context)!.settings.arguments as String?;

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageHeader(),
               SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: PageHeading(title: 'sign_up'),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'username'.tr(),
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        labelText: 'email'.tr(),
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        labelText: 'password'.tr(),
                        prefixIcon: Icons.lock,
                        isObscureText: true,
                      ),
                      SizedBox(height: 10.h),

                      CustomTextFormField(
                        labelText: 'phone'.tr(),
                        prefixIcon: Icons.phone,
                      ),
                      SizedBox(height: 10.h),

                      if (userType == 'Technician') ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.whiteTextColor,
                            border: Border.all(
                              color: AppColors.lightprimarycolor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRole,
                              hint: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      end: 12.w,
                                    ),
                                    child: Icon(
                                      Icons.construction,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'select_role'.tr(),
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              items:
                                  roles.map((String role) {
                                    return DropdownMenuItem<String>(
                                      value: role,
                                      child: Text(
                                        role.tr(),
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
                            (routes)=> false,
                            arguments: '$userType',
                          );
                        },
                        text: "sign_up".tr(),
                        size: Size(size.width.w, 48.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.whiteTextColor,
                      ),
                      SizedBox(height: 20.h),
                      CustomHyperLink(
                        title: 'already_have_account'.tr(),
                        link: 'login'.tr(),
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
      ),
    );
  }
}
