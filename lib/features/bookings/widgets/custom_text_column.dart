import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';

class CustomTextColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomTextColumn({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.lightprimarycolor,
            fontWeight: FontWeight.w800,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: double.infinity,
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.visible,
            softWrap: true,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
