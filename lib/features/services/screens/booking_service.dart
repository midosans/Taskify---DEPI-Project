import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_TextFormField.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/features/bookings/cubit/create_booking_cubit.dart';
import 'package:taskify/features/bookings/cubit/create_booking_state.dart';
import 'package:taskify/core/widgets/custom_dotted_border.dart';
import 'package:taskify/features/services/widgets/custom_time_picker.dart';
import 'package:taskify/features/services/data/services_model.dart';

class BookingService extends StatefulWidget {
  final ServicesModel serviceModel;

  const BookingService({super.key, required this.serviceModel});

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  final formKey = GlobalKey<FormState>();
  bool _submitted = false;
  XFile? pickedimg;

  final TextEditingController addressController = TextEditingController();

  final GlobalKey<CustomTimePickerState> dateKey = GlobalKey();
  final GlobalKey<CustomTimePickerState> timeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Text(
          "book_service".tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 22.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: BlocListener<CreateBookingCubit, CreateBookingState>(
        listener: (context, state) async {
          // -------------------- LOADING --------------------
          if (state is CreateBookingLoading) {
            // Close any previous dialogs
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }
          // -------------------- SUCCESS --------------------
          else if (state is CreateBookingSuccess) {
            // Close loading dialog
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "booking_success_title".tr(),
                    subtitle: "booking_success_subtitle".tr(),
                    buttontext: "ok".tr(),
                    icon: Icons.check_circle,
                  ),
            ).then((_) {
              if (context.mounted) {
                Navigator.of(context).pop(true); // refresh previous screen
              }
            });
          }
          // -------------------- ERROR --------------------
          else if (state is CreateBookingError) {
            // Close any dialog
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            showDialog(
              context: context,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "error_title".tr(),
                    subtitle: state.message,
                    buttontext: "ok".tr(),
                    icon: Icons.error,
                  ),
            );
          }
        },

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Form(
            key: formKey,
            autovalidateMode:
                _submitted
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
            child: ListView(
              children: [
                Text(
                  widget.serviceModel.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                // ---------------- Service Info ----------------
                ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.lightGreyColor,
                    ),
                    height: 48.h,
                    width: 48.w,
                    child: SvgPicture.asset(
                      'assets/svgs/setting.svg',
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.none,
                    ),
                  ),
                  title: Text(
                    (widget.serviceModel.category!).toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    widget.serviceModel.providername ?? '',
                    style: TextStyle(color: AppColors.lightprimarycolor),
                  ),
                ),
                SizedBox(height: 20.h),

                // ---------------- Image Picker ----------------
                GestureDetector(
                  onTap: () async {
                    final XFile? pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile == null) return;
                    setState(() => pickedimg = pickedFile);
                  },
                  child:
                      pickedimg == null
                          ? CustomDottedBorder(
                            children: [
                              Text(
                                "upload_media".tr(),
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text("upload_note".tr()),
                            ],
                          )
                          : Image.file(File(pickedimg!.path)),
                ),
                SizedBox(height: 20.h),

                // ---------------- Date Picker ----------------
                Text(
                  'select_date'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8),

                CustomTimePicker(key: dateKey, isTime: false),
                SizedBox(height: 20),

                // ---------------- Time Picker ----------------
                Text(
                  'select_time'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8),

                CustomTimePicker(key: timeKey, isTime: true),
                SizedBox(height: 20.h),

                // ---------------- Address ----------------
                Text(
                  "address".tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),

                CustomTextFormField(
                  controller: addressController,
                  labelText: "enter_address".tr(),
                ),
                SizedBox(height: 25.h),

                // ---------------- Confirm Button ----------------
                CustomButton(
                  text: 'confirm_booking'.tr(),
                  size: Size(size.width.w, 48.h),
                  color: AppColors.primaryColor,
                  fontColor: AppColors.whiteTextColor,
                  onPressed: () {
                    final date = dateKey.currentState?.selectedDate;
                    final time = timeKey.currentState?.selectedTime;

                    debugPrint("DATE: $date");
                    debugPrint("TIME: $time");

                    setState(() => _submitted = true);

                    if (formKey.currentState!.validate() && pickedimg != null) {
                      context.showBlocDialog(
                        cubit: context.read<CreateBookingCubit>(),
                        dialog: CustomConfirmDialog(
                          title: "confirm_booking_title".tr(),
                          subtitle: "confirm_booking_subtitle".tr(),
                          buttontext: "confirm".tr(),
                          onConfirm: () {
                            Navigator.of(context, rootNavigator: true).pop();

                            context.read<CreateBookingCubit>().createBooking(
                              serviceId: widget.serviceModel.id!,
                              providerId: widget.serviceModel.providerid!,
                              providerName: widget.serviceModel.providername!,
                              serviceTitle: widget.serviceModel.title!,
                              date: date!,
                              time: DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                time!.hour,
                                time.minute,
                              ),
                              address: addressController.text,
                              photo: File(pickedimg!.path),
                            );
                          },
                        ),
                      );
                    } else if (pickedimg == null) {
                      context.showBlocDialog(
                        cubit: context.read<CreateBookingCubit>(),
                        dialog: CustomNotifyDialog(
                          title: "missing_photo".tr(),
                          subtitle: "missing_photo_subtitle".tr(),
                          buttontext: "ok".tr(),
                          icon: Icons.error_outline,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
