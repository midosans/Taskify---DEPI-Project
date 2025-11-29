import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_button.dart';

class CustomNoInternetDialog extends StatelessWidget {
  const CustomNoInternetDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttontext,
    required this.onConfirm,
    
  });
  final String title;
  final String subtitle;
  final String buttontext;
  final VoidCallback onConfirm;
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.live_help_outlined,
              color: AppColors.primaryColor,
              size: 48,
            ),
             SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blackTextColor,
              ),
            ),
             SizedBox(height: 12.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: AppColors.greyTextColor),
            ),
             SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  text: buttontext,
                  size: Size(120.w, 50.h),
                  color: AppColors.primaryColor,
                  fontColor: AppColors.secondaryBottomColor,
                  onPressed: onConfirm,
                ),
                CustomButton(
                  text: 'exit'.tr(),
                  size: Size(120.w, 50.h),
                  color: AppColors.deleteColor,
                  fontColor: AppColors.secondaryBottomColor,
                  onPressed: () {
                   SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
