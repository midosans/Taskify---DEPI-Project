import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class CustomListTileForProvider extends StatelessWidget {
  final BookingModel service;

  const CustomListTileForProvider({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          children: [
            // Text section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(service.date!),
                      style: TextStyle(color: AppColors.lightprimarycolor),
                    ),
                    Text(
                      service.serviceTitle!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "by_vendor".tr(args: [service.providerName!]),
                      style: TextStyle(color: AppColors.lightprimarycolor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 4.h,
                      ),
                      child: Container(
                        height: 32.h,
                        width: 147.w,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              service.address!,
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            SvgPicture.asset(
                              'assets/svgs/location.svg',
                              width: 18.w,
                              height: 18.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBottomColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        width: 150.w,
                        height: 32.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              service.status.toUpperCase(),
                              style: TextStyle(
                                color: AppColors.blackTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(width: 8.w),

                            SvgPicture.asset(
                              'assets/svgs/right_mark.svg',
                              width: 16.w,
                              height: 16.h,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
            // Image section
            Container(
              width: 100.h,
              height: 100.h,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset(service.imageUrl!).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Format to "Mon, Jul 15 • 10:00 AM"
    final formatter = DateFormat('E, MMM d • h:mm a');
    return formatter.format(dateTime);
  }
}
