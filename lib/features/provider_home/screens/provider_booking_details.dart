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
import 'package:taskify/features/services/cubit/contact_cubit.dart';
import 'package:taskify/features/services/cubit/contact_state.dart';
import 'package:taskify/features/services/widgets/launcher_helper.dart';

class ProviderBookingDetails extends StatefulWidget {
  final BookingModel bookingdeatils;
  const ProviderBookingDetails({super.key, required this.bookingdeatils});

  @override
  State<ProviderBookingDetails> createState() => _ProviderBookingDetailsState();
}

class _ProviderBookingDetailsState extends State<ProviderBookingDetails> {
  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getPhone(
      providerId: widget.bookingdeatils.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdateBookingCubit>();

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
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is UpdateBookingSuccess) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "service_updated".tr(),
                    subtitle: "service_updated_msg".tr(),
                    buttontext: "ok".tr(),
                    icon: Icons.check_circle,
                  ),
            ).then((_) {
              if (context.mounted) Navigator.of(context).pop(true);
            });
          } else if (state is UpdateBookingFailure) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "error".tr(),
                    subtitle: state.errorMessage,
                    buttontext: "ok".tr(),
                    icon: Icons.error,
                  ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "order_details".tr(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),

              /// Header Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.bookingdeatils.serviceTitle ??
                              'unnamed_service'.tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                                    ? '${_formatDateTime(widget.bookingdeatils.date!)} • ${_cleanTime(widget.bookingdeatils.time!)}'
                                    : "scheduled_for".tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.lightprimarycolor,
                                ),
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

              const Divider(height: 25),

              Row(
                children: [
                  Expanded(
                    child: CustomTextColumn(
                      title: "service".tr(),
                      subtitle:
                          widget.bookingdeatils.serviceTitle ??
                          'unnamed_service'.tr(),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextColumn(
                      title: "client".tr(),
                      subtitle:
                          widget.bookingdeatils.userName ??
                          'not_specified'.tr(),
                    ),
                  ),
                ],
              ),

              const Divider(height: 25),

              if (widget.bookingdeatils.date != null)
                Row(
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
                        subtitle: _formatTime(widget.bookingdeatils.date!),
                      ),
                    ),
                  ],
                ),

              const Divider(height: 25),

              Text(
                "address".tr(),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.lightprimarycolor,
                ),
              ),
              Text(
                widget.bookingdeatils.address ?? 'no_address'.tr(),
                style: TextStyle(fontSize: 14.sp),
              ),

              const Spacer(),

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
                  ),
                ),
                title: Text(
                  "contact_client".tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "contact_provider_subtitle".tr(),
                  style: TextStyle(color: AppColors.lightprimarycolor),
                ),
                onTap: () {
                  final phone =
                      context.read<ContactCubit>().state is ContactSuccess
                          ? (context.read<ContactCubit>().state
                                  as ContactSuccess)
                              .contactModel
                              .phone
                          : null;
                  if (phone != null) {
                    LauncherHelper.openDialer(phone);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('provider_number_unavailable'.tr()),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: 10.h),

              widget.bookingdeatils.status == 'accepted'
                  ? CustomButton(
                    text: "mark_as_completed".tr(),
                    size: Size(250.w, 45.h),
                    color: AppColors.primaryColor,
                    fontColor: AppColors.secondaryBottomColor,
                    onPressed: () {
                      context.showBlocDialog(
                        cubit: cubit,
                        dialog: CustomConfirmDialog(
                          title: "finish_service".tr(),
                          subtitle: "finish_service_subtitle".tr(
                            namedArgs: {
                              "service":
                                  widget.bookingdeatils.serviceTitle ?? "",
                            },
                          ),
                          buttontext: "finish".tr(),
                          onConfirm: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            cubit.updateBoookingStatus(
                              status: "completed",
                              bookingId: widget.bookingdeatils.id!,
                            );
                          },
                        ),
                      );
                    },
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        text: "accept".tr(),
                        size: Size(170.w, 40.h),
                        color: AppColors.primaryColor,
                        fontColor: AppColors.secondaryBottomColor,
                        onPressed: () {
                          context.showBlocDialog(
                            cubit: cubit,
                            dialog: CustomConfirmDialog(
                              title: "accept_service".tr(),
                              subtitle: "accept_service_subtitle".tr(
                                namedArgs: {
                                  "service":
                                      widget.bookingdeatils.serviceTitle ?? "",
                                },
                              ),
                              buttontext: "accept".tr(),
                              onConfirm: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                                cubit.updateBoookingStatus(
                                  status: "accepted",
                                  bookingId: widget.bookingdeatils.id!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      CustomButton(
                        text: "decline".tr(),
                        size: Size(170.w, 40.h),
                        color: AppColors.deleteColor,
                        fontColor: AppColors.whiteTextColor,
                        onPressed: () {
                          context.showBlocDialog(
                            cubit: cubit,
                            dialog: CustomConfirmDialog(
                              title: "cancel_service".tr(),
                              subtitle: "cancel_service_subtitle".tr(
                                namedArgs: {
                                  "service":
                                      widget.bookingdeatils.serviceTitle ?? "",
                                },
                              ),
                              buttontext: "decline".tr(),
                              onConfirm: () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                                cubit.updateBoookingStatus(
                                  status: "cancelled",
                                  bookingId: widget.bookingdeatils.id!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),

              const Divider(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (widget.bookingdeatils.imageUrl == null ||
        widget.bookingdeatils.imageUrl!.isEmpty) {
      return Image.asset('assets/pngs/logo.png', fit: BoxFit.cover);
    }

    if (widget.bookingdeatils.imageUrl!.startsWith('http')) {
      return Image.network(widget.bookingdeatils.imageUrl!, fit: BoxFit.cover);
    }

    return Image.asset(widget.bookingdeatils.imageUrl!, fit: BoxFit.cover);
  }
}

String _formatDateTime(DateTime dateTime) {
  return DateFormat('E, MMM d').format(dateTime);
}

String _cleanTime(String time) {
  return time.substring(0, 5);
}
