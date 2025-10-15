import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.size,
    this.isBuld = false,
    this.fontSize,
  });

  final void Function()? onPressed;
  final String text;
  final Size? size;
  final bool isBuld;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Text(
        text.tr(),
        style: TextStyle(
          fontSize: (fontSize ?? 14).sp,
          color: AppColors.whiteTextColor,
          fontWeight: isBuld ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
