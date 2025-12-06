import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/widgets/custom_text_column.dart';
import 'package:taskify/features/services/cubit/contact_cubit.dart';
import 'package:taskify/features/services/cubit/contact_state.dart';
import 'package:taskify/features/services/widgets/launcher_helper.dart';

class BookingDetails extends StatefulWidget {
  final BookingModel bookingdeatils;
  const BookingDetails({super.key, required this.bookingdeatils});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getPhone(
      providerId: widget.bookingdeatils.providerId!,
    );
  }

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.bookingdeatils.serviceTitle ?? 'Unnamed Service',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackTextColor,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14.sp,
                            color: AppColors.lightprimarycolor,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              widget.bookingdeatils.date != null
                                  ? _formatFullDateTime(
                                    widget.bookingdeatils.date!,
                                  )
                                  : 'scheduled_for'.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.lightprimarycolor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    width: 130.w,
                    height: 66.h,
                    child: CustomCashedImage(
                      url: widget.bookingdeatils.imageUrl!,
                      size: Size(130.w, 66.h),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextColumn(
                      title: "service".tr(),
                      subtitle:
                          widget.bookingdeatils.serviceTitle ??
                          'Unnamed Service',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextColumn(
                      title: "vendor".tr(),
                      subtitle:
                          widget.bookingdeatils.providerName ?? 'Not specified',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
            if (widget.bookingdeatils.date != null)
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomTextColumn(
                        title: "date".tr(),
                        subtitle: _formatDateTime(widget.bookingdeatils.date!),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomTextColumn(
                        title: "time".tr(),
                        subtitle: _cleanTime(widget.bookingdeatils.time!),
                      ),
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
            Text(
              widget.bookingdeatils.address ?? 'No address provided',
              style: TextStyle(fontSize: 14.sp),
            ),
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
              onTap: () {
                final phone =
                    context.read<ContactCubit>().state is ContactSuccess
                        ? (context.read<ContactCubit>().state as ContactSuccess)
                            .contactModel
                            .phone
                        : null;
                if (phone != null) {
                  LauncherHelper.openDialer(phone);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('provider_number_unavailable'.tr())),
                  );
                }
              },
            ),
            const Divider(thickness: 0.45, indent: 1, endIndent: 2, height: 25),
          ],
        ),
      ),
    );
  }
}

String _cleanTime(String time) {
  return time.substring(0, 5); // "06:25"
}

String _formatFullDateTime(DateTime dateTime) {
  final formatter = DateFormat('E, MMM d • h:mm a');
  return formatter.format(dateTime);
}

String _formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('E, MMM d');
  return formatter.format(dateTime);
}
