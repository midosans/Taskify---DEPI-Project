import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/features/auth/widgets/custom_hyper_link.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  String selectedUserType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'welcome'.tr(),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'select_role_to_start'.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.greyTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                Text(
                  'i_am'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'User';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 35).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color:
                            selectedUserType == 'User'
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                      color:
                          selectedUserType == 'User'
                              ? AppColors.primaryColor.withOpacity(0.1)
                              : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person,
                          size: 40.sp,
                          color:
                              selectedUserType == 'User'
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'customer'.tr(),
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                selectedUserType == 'User'
                                    ? AppColors.primaryColor
                                    : AppColors.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedUserType = 'Technician';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 35).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color:
                            selectedUserType == 'Technician'
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                      color:
                          selectedUserType == 'Technician'
                              ? AppColors.primaryColor.withOpacity(0.1)
                              : Colors.white,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.construction,
                          size: 40.sp,
                          color:
                              selectedUserType == 'Technician'
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'technician'.tr(),
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                selectedUserType == 'Technician'
                                    ? AppColors.primaryColor
                                    : AppColors.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 150.h),
                ElevatedButton(
                  onPressed: () {
                    if (selectedUserType.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomNotifyDialog(
                            title: 'please_select_role'.tr(),
                            subtitle: 'need_to_choose_role'.tr(),
                            buttontext: 'ok'.tr(),
                            icon: Icons.warning_amber_rounded,
                          );
                        },
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        registerScreenRoute,
                        arguments: selectedUserType,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'continue'.tr(),
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),
                CustomHyperLink(
                  title: 'already_have_account'.tr(),
                  link: 'login'.tr(),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, loginScreenRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
