import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSettingsItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 8.0.h),
    child: InkWell(
      borderRadius: BorderRadius.circular(9.r),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: Colors.black87),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              title,
              style:  TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black87),
        ],
      ),
    ),
  );
}