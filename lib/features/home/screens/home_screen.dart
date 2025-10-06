import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/home/widgets/home_grid_view.dart';
import 'package:taskify/features/home/widgets/no_booking_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onGoToServices,
    required this.onGoToBookings,
  });
  final VoidCallback onGoToServices;
  final VoidCallback onGoToBookings;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'assets/pngs/slider1.png',
    'assets/pngs/slider2.png',
    'assets/pngs/slider3.png',
    'assets/pngs/slider4.png',
  ];

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Taskify',
          style: TextStyle(
            color: AppColors.blackTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                height: 160.h,
                viewportFraction: 1,
                disableCenter: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
              items: List.generate(images.length, (index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10.r),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: size.width,
                          height: size.height * 0.3,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 0,
                      right: 0,
                      child: DotsIndicator(
                        dotsCount: images.length,
                        position: pageIndex.toDouble(),
                        decorator: DotsDecorator(
                          spacing: EdgeInsets.symmetric(horizontal: 4.w),
                          size: Size(24.w, 6.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20.r),
                          ),
                          activeSize: Size(24.w, 6.h),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(20.r),
                          ),
                          color: Colors.grey,
                          activeColor: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'services'.tr(),
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                      Text(
                        'choose_service'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: widget.onGoToServices,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      'view_all'.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            HomeGridView(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    'bookings'.tr(),
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: widget.onGoToBookings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      'view_all'.tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            NoBookingsCard(onExploreServices: widget.onGoToServices),
          ],
        ),
      ),
    );
  }
}
