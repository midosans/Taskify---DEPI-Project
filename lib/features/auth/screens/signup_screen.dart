import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/features/auth/cubit/signup_cubit.dart';
import 'package:taskify/features/auth/cubit/signup_state.dart';
import 'package:taskify/features/auth/widgets/custom_hyper_link.dart';
import 'package:taskify/features/auth/widgets/custom_image_header.dart';
import 'package:taskify/features/auth/widgets/custom_text_header.dart';
import 'package:taskify/app_services/validator_service.dart';

class SignUpScreen extends StatefulWidget {
  final String? userType;
  const SignUpScreen({super.key, this.userType});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;

  String? email, password, phone, username;
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
    final userType = widget.userType;
    final size = MediaQuery.sizeOf(context);
    final emailValidator = EmailValidator();
    final passwordValidator = PasswordValidator();
    final phoneValidator = EgyptianPhoneValidator();

    return Scaffold(
      body: SafeArea(
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is SignupLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (_) => const Center(child: CircularProgressIndicator()),
                );
              } else if (state is SignupSuccess) {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  layoutWrapperRoute,
                  (routes) => false,
                  arguments: '$userType',
                );
              } else if (state is SignupFailure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            });
          },
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
                    key: formKey,
                    autovalidateMode:
                        _submitted
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: 'username'.tr(),
                          prefixIcon: Icons.person,
                          onChanged: (value) => username = value,
                        ),
                        SizedBox(height: 10.h),

                        CustomTextFormField(
                          labelText: 'email'.tr(),
                          prefixIcon: Icons.email,
                          onChanged: (value) => email = value,
                          validator: emailValidator.validate,
                        ),
                        SizedBox(height: 10.h),

                        CustomTextFormField(
                          labelText: 'password'.tr(),
                          prefixIcon: Icons.lock,
                          isObscureText: true,
                          onChanged: (value) => password = value,
                          validator: passwordValidator.validate,
                        ),
                        SizedBox(height: 10.h),

                        CustomTextFormField(
                          labelText: 'phone'.tr(),
                          prefixIcon: Icons.phone,
                          onChanged: (value) => phone = value,
                          validator: phoneValidator.validate,
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
                                    roles
                                        .map(
                                          (String role) =>
                                              DropdownMenuItem<String>(
                                                value: role,
                                                child: Text(
                                                  role.tr(),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              ),
                                        )
                                        .toList(),
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

                        CustomButton(
                          onPressed: () {
                            setState(() => _submitted = true);
                            if (formKey.currentState!.validate()) {
                              context.read<SignupCubit>().SignUp(
                                email: email!,
                                password: password!,
                                role:
                                    userType == 'Technician'
                                        ? selectedRole ?? ''
                                        : 'User',
                                username: username!,
                                phone: phone!,
                              );
                            }
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
      ),
    );
  }
}