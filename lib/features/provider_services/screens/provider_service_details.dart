import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/services/data/services_model.dart';

class ProviderServiceDetails extends StatelessWidget {
  final ServicesModel servicesModel;

  const ProviderServiceDetails({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          servicesModel.title ?? '',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 22.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    servicesModel.photo ?? '',
                    width: MediaQuery.of(context).size.width,
                    height: 250.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          servicesModel.title ?? '',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            '${servicesModel.price ?? ''} EGP',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          servicesModel.description ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 14,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
