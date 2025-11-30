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

// ---------------------------
// BookingService (optimized)
// ---------------------------
class BookingService extends StatefulWidget {
  final ServicesModel serviceModel;

  const BookingService({super.key, required this.serviceModel});

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  final _formKey = GlobalKey<FormState>();
  bool _submitted = false;
  XFile? _pickedImg;
  final TextEditingController _addressController = TextEditingController();

  // Keys remain but usage is light — keep for compatibility with existing CustomTimePicker API.
  final GlobalKey<CustomTimePickerState> _dateKey = GlobalKey();
  final GlobalKey<CustomTimePickerState> _timeKey = GlobalKey();

  final ImagePicker _imagePicker = ImagePicker();

  // Prevent multiple dialogs stacking
  bool _dialogShowing = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      // Reduce image size on pick to avoid heavy decodes later.
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200, // limits decode size
        maxHeight: 1200,
        imageQuality: 75, // compress moderately
      );
      if (pickedFile == null) return;
      setState(() => _pickedImg = pickedFile);
    } catch (e) {
      // optional: show a tiny snackbar
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('image_pick_failed'.tr())));
      }
    }
  }

  void _safeShowDialog(
    Widget dialog, {
    bool useRoot = false,
    bool barrierDismissible = true,
  }) {
    if (!mounted) return;
    if (_dialogShowing) return;
    _dialogShowing = true;

    showDialog(
      context: context,
      useRootNavigator: useRoot,
      barrierDismissible: barrierDismissible,
      builder:
          (_) => WillPopScope(
            onWillPop: () async => barrierDismissible,
            child: dialog,
          ),
    ).then((_) => _dialogShowing = false);
  }

  void _safePopDialog({bool root = true}) {
    if (!mounted) return;
    final navigator =
        root
            ? Navigator.of(context, rootNavigator: true)
            : Navigator.of(context);
    if (navigator.canPop()) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Text(
          'book_service'.tr(),
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
          // Unified dialog handling: avoid stacking and ensure safe pops
          if (state is CreateBookingLoading) {
            _safeShowDialog(
              const Center(child: CircularProgressIndicator()),
              useRoot: true,
              barrierDismissible: false,
            );
          } else if (state is CreateBookingSuccess) {
            _safePopDialog(root: true); // close loading

            if (!mounted) return;
            // show success
            _safeShowDialog(
              CustomNotifyDialog(
                title: 'booking_success_title'.tr(),
                subtitle: 'booking_success_subtitle'.tr(),
                buttontext: 'ok'.tr(),
                icon: Icons.check_circle,
              ),
              barrierDismissible: false,
            );

            // After dialog closes return true so previous screen can refresh
            Future.delayed(Duration.zero, () {
              // wait for the notify dialog to finish
              // Using then isn't always reliable if other dialogs popped, so check mounted.
            });
          } else if (state is CreateBookingError) {
            _safePopDialog(root: true);
            if (!mounted) return;
            _safeShowDialog(
              CustomNotifyDialog(
                title: 'error_title'.tr(),
                subtitle: state.message,
                buttontext: 'ok'.tr(),
                icon: Icons.error,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Form(
            key: _formKey,
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

                // Service Info
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
                    (widget.serviceModel.category ?? '').toUpperCase(),
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

                // Image Picker (small, constrained preview)
                GestureDetector(
                  onTap: _pickImage,
                  child:
                      _pickedImg == null
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
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(_pickedImg!.path),
                              width: double.infinity,
                              height: 180.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                ),
                SizedBox(height: 20.h),

                // Date + Time pickers
                Text(
                  'select_date'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTimePicker(key: _dateKey, isTime: false),
                SizedBox(height: 20.h),

                Text(
                  'select_time'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTimePicker(key: _timeKey, isTime: true),
                SizedBox(height: 20.h),

                // Address
                Text(
                  'address'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: _addressController,
                  labelText: 'enter_address'.tr(),
                ),
                SizedBox(height: 25.h),

                // Confirm Button
                CustomButton(
                  text: 'confirm_booking'.tr(),
                  size: Size(size.width.w, 48.h),
                  color: AppColors.primaryColor,
                  fontColor: AppColors.whiteTextColor,
                  onPressed: () {
                    final date = _dateKey.currentState?.selectedDate;
                    final time = _timeKey.currentState?.selectedTime;

                    setState(() => _submitted = true);

                    if (_formKey.currentState?.validate() == true &&
                        _pickedImg != null &&
                        date != null &&
                        time != null) {
                      context.showBlocDialog(
                        cubit: context.read<CreateBookingCubit>(),
                        dialog: CustomConfirmDialog(
                          title: 'confirm_booking_title'.tr(),
                          subtitle: 'confirm_booking_subtitle'.tr(),
                          buttontext: 'confirm'.tr(),
                          onConfirm: () {
                            Navigator.of(context, rootNavigator: true).pop();

                            // Build a combined DateTime for time slot
                            final bookingTime = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );

                            context.read<CreateBookingCubit>().createBooking(
                              serviceId: widget.serviceModel.id!,
                              providerId: widget.serviceModel.providerid!,
                              providerName: widget.serviceModel.providername!,
                              serviceTitle: widget.serviceModel.title!,
                              date: date,
                              time: bookingTime,
                              address: _addressController.text,
                              photo: File(_pickedImg!.path),
                            );
                          },
                        ),
                      );
                    } else if (_pickedImg == null) {
                      context.showBlocDialog(
                        cubit: context.read<CreateBookingCubit>(),
                        dialog: CustomNotifyDialog(
                          title: 'missing_photo'.tr(),
                          subtitle: 'missing_photo_subtitle'.tr(),
                          buttontext: 'ok'.tr(),
                          icon: Icons.error_outline,
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
