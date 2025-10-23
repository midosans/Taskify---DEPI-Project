import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/provider_services/screens/provider_add_service_screen.dart';
import 'package:taskify/features/services/data/services_model.dart';

class ProviderServicesScreens extends StatelessWidget {
  ProviderServicesScreens({super.key});

  final List<ServicesModel> proServices = [
    ServicesModel(
      category: 'Plumbing',
      description: 'Fixing leaks and clogs',
      title: 'Pipe Repair',
      price: 50.0,
      photo: 'assets/pngs/provider_service1.png',
    ),
    ServicesModel(
      category: 'Electrical',
      description:
          'Wiring and installations Wiring and installations Wiring and installations Wiring and installations',
      title: 'Wiring Setup',
      price: 75.0,
      photo: 'assets/pngs/provider_service2.png',
    ),
    ServicesModel(
      category: 'Cleaning',
      description: 'Home and office cleaning',
      title: 'Deep Cleaning',
      price: 100.0,
      photo: 'assets/pngs/provider_service3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'my_services'.tr(),
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final service = proServices[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    providerServiceDetailsRoute,
                    arguments: service,
                  ),
              child: SizedBox(
                height: 130.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.category!,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            service.title!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            service.description!,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$${service.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 110.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffF0F2F5),
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                minimumSize: Size(80.w, 30.h),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  providerServiceDetailsRoute,
                                );
                              },
                              child: Center(
                                child: Text(
                                  'view_details'.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blackTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: SizedBox(
                        width: 130.w,
                        height: 130.h,
                        child: Image.asset(service.photo!, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: proServices.length,
      ),
      floatingActionButton: SizedBox(
        height: 50.h,
        width: 140.w,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => ProviderAddServiceScreen(),
              ),
            );
          },
          backgroundColor: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30.sp, color: AppColors.whiteTextColor),
              SizedBox(width: 4.w),
              Text(
                'add_service'.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
