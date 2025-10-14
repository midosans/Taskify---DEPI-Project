import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class CustomTile extends StatelessWidget {
  final BookingModel service;

  const CustomTile({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundColor,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:8.w),
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
                      _formatDateTime(service.bookingDate!),
                      style: TextStyle(color: AppColors.lightprimarycolor),
                    ),
                    Text(
                      service.serviceName!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Text("By ${service.vendorName}",style: TextStyle(color: AppColors.lightprimarycolor),),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
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
                            Text(service.address!, style: TextStyle(
                              fontSize: 12.sp,
                            ),),
                            SvgPicture.asset('assets/svgs/location.svg', width: 18.w, height: 18.h),
                          ],
                        )
                        ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.status.toString().toUpperCase(),
                      style: TextStyle(
                        color: _getStatusColor(service.status!),
                        fontWeight: FontWeight.w600,
                      ),
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
                  image: Image.asset(service.serviceImage!).image,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'upcoming':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}