import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';


class UserTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const UserTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 35).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
            width: 2,
          ),
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.white,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40.sp,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.blackTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
