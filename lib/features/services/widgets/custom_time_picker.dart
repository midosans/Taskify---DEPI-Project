import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';


class CustomTimePicker extends StatefulWidget {
  final bool isTime;
  const CustomTimePicker({super.key, required this.isTime});

  @override
  CustomTimePickerState createState() => CustomTimePickerState();
}

class CustomTimePickerState extends State<CustomTimePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  String _getDisplayText(BuildContext context) {
    if (!widget.isTime) {
      return selectedDate != null
          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
          : "choose_date".tr();
    } else {
      return selectedTime != null
          ? selectedTime!.format(context)
          : "choose_time".tr();
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      useRootNavigator: true,
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
        useRootNavigator: true,
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isTime ? _pickTime : _pickDate,
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
              _getDisplayText(context),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.lightprimarycolor,
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.purple),
          ],
        ),
      ),
    );
  }
}