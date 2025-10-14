import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/auth/widgets/custom_TextFormField.dart';
import 'package:taskify/features/auth/widgets/custom_button.dart';
import 'package:taskify/features/bookings/widgets/custom_dotted_border.dart';
import 'package:taskify/features/bookings/widgets/custom_time_picker.dart';

class BookingService extends StatefulWidget {
  const BookingService({super.key});

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  XFile? pickedimg;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "book_service".tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Text(
              "service_details".tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            SizedBox(height: 10.h),
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
                "ac_technician".tr(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "ahmed_ali".tr(),
                style: TextStyle(color: AppColors.lightprimarycolor),
              ),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () async {
                final XFile? pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile == null) return;

                setState(() {
                  pickedimg = pickedFile;
                });
              },
              child: pickedimg == null
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
            SizedBox(height: 10.h),
            Text(
              'select_date'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            const CustomTimePicker(isTime: false),
            const SizedBox(height: 20),
            Text(
              'select_time'.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            const CustomTimePicker(isTime: true),
            SizedBox(height: 10),
            Text(
              "address".tr(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: CustomTextformfield(labelText: "enter_address".tr()),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'confirm_booking'.tr(),
              size: Size(size.width.w, 48.h),
              color: AppColors.primaryColor,
              fontColor: AppColors.whiteTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
