import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({super.key});


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'Taskify',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "new_orders".tr(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return CustomListTileForProvider(service: bookingListAccept[index]);
          //   }, childCount: bookingListAccept.length),
          // ),

           SliverToBoxAdapter(child: SizedBox(height: 16.h)),

           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "ongoing_work".tr(),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return CustomListTileForProvider(service: bookingListOngoing[index]);
          //   }, childCount: bookingListOngoing.length),
          // ),
        ],
      ),
    );
  }
}
