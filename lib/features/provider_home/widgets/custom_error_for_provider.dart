import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_dotted_border.dart';

class CustomErrorForProvider extends StatelessWidget {
  final String subtitle;
  final VoidCallback onRefresh;
  const CustomErrorForProvider({
    super.key,
    required this.subtitle,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 347.h,
      width: double.infinity,
      child: Center(
        child: CustomDottedBorder(
          height: 300.h,
          children: [
            Text("unexpected_error".tr(),
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
      ),
    );
  }
}
