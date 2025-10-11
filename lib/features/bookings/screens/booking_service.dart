import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/auth/widgets/custom_button.dart';

class BookingService extends StatefulWidget {
  BookingService({super.key});

  @override
  State<BookingService> createState() => _BookingServiceState();
}

class _BookingServiceState extends State<BookingService> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  XFile? pickedimg;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Service",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Text(
              "service details",
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
                "AC Technician",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Ahmed Ali",
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
              child:
                  pickedimg == null
                      ? DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashPattern: [5, 4],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          width: size.width * 0.9,
                          height: 168.h,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Upload photos/videos",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text("Max 5 items, jpg/png/mp4, max 10MB each"),
                              ],
                            ),
                          ),
                        ),
                      )
                      : Image.file(File(pickedimg!.path)),
            ),
            SizedBox(height: 10.h),
            Text(
              'Select Date',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteTextColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                          : 'Choose Date',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lightprimarycolor,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.purple),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select Time',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickTime,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteTextColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : 'Choose Time',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lightprimarycolor,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Colors.purple),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Address",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  hintText: "Enter your address",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightprimarycolor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'Confirm Booking',
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
