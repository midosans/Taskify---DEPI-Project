import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';

class NoBookingsCard extends StatelessWidget {
  const NoBookingsCard({super.key, this.onExploreServices});
  final VoidCallback? onExploreServices;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Center(
      child: DottedBorder(
        color: Colors.grey,
        strokeWidth: 1,
        dashPattern: [5, 4],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: Container(
          width: size.width * 0.9,
          height: 200.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'no_bookings_yet'.tr(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'no_bookings_message'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onExploreServices,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGreyColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                    const Text(
                      'explore_services',
                      style: TextStyle(color: AppColors.blackTextColor),
                    ).tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
