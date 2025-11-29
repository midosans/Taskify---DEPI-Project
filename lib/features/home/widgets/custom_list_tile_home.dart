import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';

class CustomListTileHome extends StatelessWidget {
  const CustomListTileHome({
    super.key,
    required this.imageUrl,
    required this.titleText,
    required this.status,
  });

  final String imageUrl;
  final String titleText;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.replace(
                    child: Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Skeleton.replace(
                    child: Text(status, style: TextStyle(fontSize: 13.sp)),
                  ),
                  SizedBox(height: 6.h),
                  Skeleton.replace(
                    child: Text(
                      'see_details'.tr(),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Skeleton.leaf(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 80.w,
                  height: 65.h,
                  color: Colors.grey[300],
                  child:
                      imageUrl.isNotEmpty
                          ? CustomCashedImage(
                            url: imageUrl,
                            size: Size(80.w, 65.h),
                            fit: BoxFit.cover,
                          )
                          : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}