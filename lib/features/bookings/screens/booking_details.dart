import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/widgets/custom_text_column.dart';

class BookingDetails extends StatelessWidget {
  final BookingModel bookingdeatils;
  const BookingDetails({super.key, required this.bookingdeatils});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'order_confirmed'.tr(),
          style: TextStyle(
            color: AppColors.blackTextColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 22.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "order_details".tr(),
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
                          "${'scheduled_for'.tr()}: ",
                          // maxLines: 2,
                          // overflow: TextOverflow.visible,
                          // softWrap: true,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.lightprimarycolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 228.w,
                        child: Text(
                          " ${_formatFullDateTime(bookingdeatils.bookingDate!)}",
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
                  CustomTextColumn(
                    title: "service".tr(),
                    subtitle: bookingdeatils.serviceName!,
                  ),
                  CustomTextColumn(
                    title: "vendor".tr(),
                    subtitle: bookingdeatils.vendorName!,
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
                  CustomTextColumn(
                    title: "date".tr(),
                    subtitle: _formatDateTime(bookingdeatils.bookingDate!),
                  ),
                  CustomTextColumn(
                    title: "time".tr(),
                    subtitle: _formatTime(bookingdeatils.bookingDate!),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            Text(
              "address".tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.lightprimarycolor,
              ),
            ),
            Text(bookingdeatils.address!, style: TextStyle(fontSize: 14.sp)),
            // SizedBox(height: 75.h),
            Spacer(),
            Text(
              "next_steps".tr(),
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
                "contact_provider".tr(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "contact_provider_subtitle".tr(),
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
  final formatter = DateFormat('E, MMM d • h:mm a');
  return formatter.format(dateTime);
}

String _formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('E, MMM d');
  return formatter.format(dateTime);
}

String _formatTime(DateTime dateTime) {
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}
