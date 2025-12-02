import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomTile extends StatelessWidget {
  final BookingModel service;
  final bool isLoading;

  const CustomTile({required this.service, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Card(
          color: AppColors.backgroundColor,
          margin: EdgeInsets.symmetric(vertical: 8.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                // Text section
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Date ---
                        Text(
                          service.date != null
                              ? '${_formatDateTime(service.date)} ${cleanTime(service.time!)}'
                              : "No date",
                          style: TextStyle(color: AppColors.lightprimarycolor),
                        ),
        
                        // --- Title ---
                        Text(
                          service.serviceTitle ?? 'Unnamed Service',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
        
                        // --- Provider ---
                        Text(
                          service.providerName != null
                              ? "By ${service.providerName}"
                              : "Provider not specified",
                          style: TextStyle(color: AppColors.lightprimarycolor),
                        ),
        
                        // --- Address container ---
                        if (service.address != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 4.h,
                            ),
                            child: Container(
                              height: 32.h,
                              width: 147.w,
                              decoration: BoxDecoration(
                                color: AppColors.lightGreyColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    service.address ?? 'No address',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  SvgPicture.asset(
                                    'assets/svgs/location.svg',
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
        
                        SizedBox(height: 4.h),
        
                        // --- Status ---
                        Text(
                          service.status.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(service.status.toLowerCase()),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        
                // --- Image section ---
                Skeleton.leaf(
                  child: Container(
                    width: 100.h,
                    height: 100.h,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _getImage(),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Date formatting
  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'No date';
    final formatter = DateFormat('E, MMM d • ');
    return formatter.format(dateTime);
  }

String cleanTime(String time) {
  return time.substring(0, 5);   // "06:25"
}

  // Status color handler
  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'accepted':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Image logic
  ImageProvider _getImage() {
    if (service.imageUrl == null || service.imageUrl!.isEmpty) {
      return const AssetImage('assets/pngs/logo.png');
    }
    if (service.imageUrl!.startsWith('http')) {
      return NetworkImage(service.imageUrl!);
    }
    return AssetImage(service.imageUrl!);
  }
}
