import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_button1.dart';
import 'package:taskify/features/services/data/services_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final ServicesModel servicesModel;

  const TaskDetailsScreen({super.key, required this.servicesModel});

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      servicesModel.photo ?? '',
                      width: MediaQuery.of(context).size.width,
                      height: 220.h,
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
                              height: 1.4,
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
          ),
          SizedBox(
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About the Vendor',
                    style: TextStyle(
                      color: AppColors.blackTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          child: Image.asset('assets/pngs/vendor_photo.png'),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              servicesModel.providername ?? '',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              servicesModel.category ?? '',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        CustomButton(onPressed: () {}, text: 'Contact'),
                      ],
                    ),
                  ),
                  CustomButton(
                    onPressed: () {},
                    text: 'Book Now',
                    size: Size(size.width.w, 48.h),
                    isBuld: true,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
