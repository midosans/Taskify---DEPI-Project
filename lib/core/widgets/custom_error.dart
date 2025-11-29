import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_button.dart';

class CustomError extends StatelessWidget {
  final String subtitle;
  final VoidCallback onRefresh;
  const CustomError({
    super.key,
    required this.subtitle,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('unexpected_error'.tr(),
            textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20.sp, fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: TextStyle(
                  fontSize: 16.sp,
                )),
            SizedBox(height: 10.h),
            SizedBox(
              width: 120.w,
  height: 40.h,
              child: CustomButton(
                text: 'refresh'.tr(),
                size: Size(30.w, 30.h),
                color: AppColors.primaryColor,
                fontColor: AppColors.secondaryBottomColor,
                onPressed: onRefresh,
              ),
            ),
          ],
        ),
      );
    
  }
}
