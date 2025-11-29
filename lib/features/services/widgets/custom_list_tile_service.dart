import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/services/data/services_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomListTileService extends StatelessWidget {
  const CustomListTileService({
    super.key,
    required this.service,
    this.isLoading = false,
  });

  final ServicesModel service;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
        color: AppColors.backgroundColor,
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---- Title ----
                        Text(
                          service.title ?? "",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // ---- Price ----
                        Text(
                          service.price != null ? '${service.price!} EGP' : "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.hintTextColor,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // ---- Button ----
                        SizedBox(
                          width: 90.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                174,
                                119,
                                194,
                              ),
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50.w, 30.h),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed:
                                isLoading
                                    ? null
                                    : () {
                                      Navigator.pushNamed(
                                        context,
                                        bookserviceRoute,
                                        arguments: service,
                                      );
                                    },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5.w),
                                Text(
                                  'book'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.backgroundColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.backgroundColor,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.w),

                  // ---- Image ----
                  Skeleton.leaf(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CustomCashedImage(
                        url: service.photo ?? "",
                        size: const Size(100, 100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
