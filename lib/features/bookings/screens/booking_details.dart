import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel bookingdeatils;
  const BookingDetails({super.key, required this.bookingdeatils});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order confirmed',
          style: TextStyle(
            color: AppColors.blackTextColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order details",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 66.h,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookingdeatils.serviceName!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 228.w,
                        child: Text(
                          "Scheduled for: ${_formatFullDateTime(bookingdeatils.bookingDate!)}",
                          maxLines: 2,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lightprimarycolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      bookingdeatils.serviceImage!,
                      height: 66.h,
                      width: 130.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            SizedBox(
              width: 185.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Service",
                        style: TextStyle(
                          color: AppColors.lightprimarycolor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 72.h,
                        child: Text(
                          bookingdeatils.serviceName!,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Provider",
                        style: TextStyle(
                          color: AppColors.lightprimarycolor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 72.h,
                        child: Text(
                          bookingdeatils.vendorName!,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            SizedBox(
              width: 185.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          color: AppColors.lightprimarycolor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 72.h,
                        child: Text(
                          _formatDateTime(bookingdeatils.bookingDate!),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time",
                        style: TextStyle(
                          color: AppColors.lightprimarycolor,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 72.h,
                        child: Text(
                          _formatTime(bookingdeatils.bookingDate!),
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            Text(
              "Address",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lightprimarycolor,
              ),
            ),
            Text(bookingdeatils.address!, style: TextStyle(fontSize: 14.sp)),
            SizedBox(height: 75.h),
            Text(
              "Next Steps",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.lightGreyColor,
                ),
                height: 48.h,
                width: 48.w,

                child: SvgPicture.asset(
                  'assets/svgs/phone.svg',
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.none,
                ),
              ),
              title: Text(
                "Contact Provider",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Contact Sophia to confirm any special requests or instructions.",
                style: TextStyle(color: AppColors.lightprimarycolor),
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
          ],
        ),
      ),
    );
  }
}

String _formatFullDateTime(DateTime dateTime) {
  // Format to "Mon, Jul 15 • 10:00 AM"
  final formatter = DateFormat('E, MMM d • h:mm a');
  return formatter.format(dateTime);
}
String _formatDateTime(DateTime dateTime) {
  // Format to "Mon, Jul 15 • 10:00 AM"
  final formatter = DateFormat('E, MMM d');
  return formatter.format(dateTime);
}
String _formatTime(DateTime dateTime) {
  // Format to "Mon, Jul 15 • 10:00 AM"
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}
