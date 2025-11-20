import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/widgets/custom_text_column.dart';
import 'package:taskify/features/provider_home/cubit/update_booking_cubit.dart';
import 'package:taskify/features/provider_home/cubit/update_booking_state.dart';

class ProviderBookingDetails extends StatelessWidget {
  final BookingModel bookingdeatils;
  const ProviderBookingDetails({super.key, required this.bookingdeatils});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateBookingCubit>();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'booking_details'.tr(),
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
      body: BlocListener<UpdateBookingCubit, UpdateBookingState>(
        listener: (context, state) async {
          if (state is UpdateBookingLoading) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is UpdateBookingSuccess) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "Service Updated",
                    subtitle: "Your Booking has been successfully Updated.",
                    buttontext: "OK",
                    icon: Icons.check_circle,
                  ),
            ).then((_) {
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            });
          } else if (state is UpdateBookingFailure) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            showDialog(
              context: context,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "Error",
                    subtitle: state.errorMessage,
                    buttontext: "OK",
                    icon: Icons.error,
                  ),
            );
          }
        },
        child: Padding(
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
                          bookingdeatils.serviceTitel ?? 'Unnamed Service',
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
                                bookingdeatils.date != null
                                    ? _formatFullDateTime(bookingdeatils.date!)
                                    : '${'scheduled_for'.tr()}',
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
                      child: _buildImage(),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.45,
                indent: 1,
                endIndent: 2,
                height: 25,
              ),
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
                            bookingdeatils.serviceTitel ?? 'Unnamed Service',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomTextColumn(
                        title: "client".tr(),
                        subtitle: bookingdeatils.userName ?? 'Not specified',
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.45,
                indent: 1,
                endIndent: 2,
                height: 25,
              ),
              if (bookingdeatils.date != null)
                SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextColumn(
                          title: "date".tr(),
                          subtitle: _formatDateTime(bookingdeatils.date!),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomTextColumn(
                          title: "time".tr(),
                          subtitle: _formatTime(bookingdeatils.date!),
                        ),
                      ),
                    ],
                  ),
                ),
              const Divider(
                thickness: 0.45,
                indent: 1,
                endIndent: 2,
                height: 25,
              ),
              Text(
                "address".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightprimarycolor,
                ),
              ),
              Text(
                bookingdeatils.address ?? 'No address provided',
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
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "contact_provider_subtitle".tr(),
                  style: TextStyle(color: AppColors.lightprimarycolor),
                ),
              ),
              SizedBox(height: 10.h),
              bookingdeatils.status == 'accepted'
                  ? CustomButton(
                    text: "mark as completed",
                    size: Size(250.w, 45.h),
                    color: AppColors.primaryColor,
                    fontColor: AppColors.secondaryBottomColor,
                    onPressed:() {
                          context.showBlocDialog(
                            cubit: cubit,
                            dialog: CustomConfirmDialog(
                              title: "finish Service",
                              subtitle:
                                  "Are you sure you want to finish ${bookingdeatils.serviceTitel}?",
                              buttontext: "Finish",
                              onConfirm: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop(); // closes the dialog
                                cubit.updateBoookingStatus(
                                  status: "completed",
                                  bookingId: bookingdeatils.id,
                                );
                              },
                            ),
                          );
                        }, 
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: "Accept",
                        size: Size(170.w, 40.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.secondaryBottomColor,
                        onPressed: () {
                          context.showBlocDialog(
                            cubit: cubit,
                            dialog: CustomConfirmDialog(
                              title: "accept Service",
                              subtitle:
                                  "Are you sure you want to Accept ${bookingdeatils.serviceTitel}?",
                              buttontext: "Accept",
                              onConfirm: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop(); // closes the dialog
                                cubit.updateBoookingStatus(
                                  status: "accepted",
                                  bookingId: bookingdeatils.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      CustomButton(
                        text: "Decline",
                        size: Size(170.w, 40.h),
                        color: AppColors.deleteColor,
                        fontColor: AppColors.whiteTextColor,
                        onPressed: () {
                          context.showBlocDialog(
                            cubit: cubit,
                            dialog: CustomConfirmDialog(
                              title: "Cancel Service",
                              subtitle:
                                  "Are you sure you want to Cancel ${bookingdeatils.serviceTitel}?",
                              buttontext: "Decline",
                              onConfirm: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop(); // closes the dialog
                                cubit.updateBoookingStatus(
                                  status: "cancelled",
                                  bookingId: bookingdeatils.id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              const Divider(
                thickness: 0.45,
                indent: 1,
                endIndent: 2,
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (bookingdeatils.imageUrl == null || bookingdeatils.imageUrl!.isEmpty) {
      return Image.asset(
        'assets/pngs/logo.png',
        height: 66.h,
        width: 130.w,
        fit: BoxFit.cover,
      );
    }

    if (bookingdeatils.imageUrl!.startsWith('http')) {
      return Image.network(
        bookingdeatils.imageUrl!,
        height: 66.h,
        width: 130.w,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      bookingdeatils.imageUrl!,
      height: 66.h,
      width: 130.w,
      fit: BoxFit.cover,
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
