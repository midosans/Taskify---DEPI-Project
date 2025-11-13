import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_app_button.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/bookings/screens/booking_service.dart';
import 'package:taskify/features/services/data/services_model.dart';
import 'package:taskify/features/services/widgets/launcher_helper.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServicesModel servicesModel;

  const ServiceDetailsScreen({super.key, required this.servicesModel});
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
                CustomCashedImage(
                  url: servicesModel.photo ?? 'assets/pngs/error.png',
                  size: Size(size.width, 250.h),
                ),
                // Image.asset(
                //   servicesModel.photo ?? '',
                //   width: MediaQuery.of(context).size.width,
                //   height: 250.h,
                //   fit: BoxFit.cover,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          servicesModel.title ?? '',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            '${'price'.tr()}: ${servicesModel.price ?? ''} ${'egp'.tr()}',
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
          SizedBox(
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'about_vendor'.tr(),
                      style: TextStyle(
                        color: AppColors.blackTextColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          child: CustomCashedImage(
                            url: 'assets/pngs/vendor_photo.png', // ⚠⚠⚠❌❌
                            size: Size(28.r, 28.r),
                          ),
                          // child: Image.asset('assets/pngs/vendor_photo.png'),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                servicesModel.providername ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                servicesModel.category?.tr() ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        CustomAppButton(
                          onPressed: () async {
                            final phoneNumber = '01060052583'; // ◀◀◀🔂
                            if (phoneNumber.isNotEmpty) {
                              await LauncherHelper.openDialer(phoneNumber);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'provider_number_unavailable'.tr(),
                                  ),
                                ),
                              );
                            }
                          },
                          text: 'contact'.tr(),
                        ),
                      ],
                    ),
                  ),
                  CustomAppButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => BookingService(),
                        ),
                      );
                    },
                    text: 'book_now'.tr(),
                    size: Size(size.width, 48.h),
                    isBuld: true,
                    fontSize: 18,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
