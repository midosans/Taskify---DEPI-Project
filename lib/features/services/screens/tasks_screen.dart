import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/bookings/screens/booking_service.dart';
import 'package:taskify/features/services/data/services_model.dart';

class TasksScreen extends StatelessWidget {
  TasksScreen({super.key});
  final List<ServicesModel> servicesModel = [
    ServicesModel(
      id: 1,
      providerid: 101,
      providername: 'John Doe',
      category: 'Plumber',
      title: 'Fix leaking pipes',
      description:
          'Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homerofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your homrofessional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your home Professional plumbing services for your hom.',
      photo: 'assets/pngs/plumber_photo.png',
      price: 50,
      duration: '1 hour',
      avilablity: 'Mon-Fri, 9am-5pm',
    ),
    ServicesModel(
      id: 2,
      providerid: 102,
      providername: 'Jane Smith',
      category: 'Plumber',
      title: 'Unclog drains',
      description: 'Expert electrical services for your home.',
      photo: 'assets/pngs/electrician_photo.png',
      price: 60,
      duration: '1 hour',
      avilablity: 'Mon-Sat, 10am-6pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          servicesModel[0].category!,
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackTextColor,
            size: 24.sp,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: servicesModel.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                taskDetailsScreenRoute,
                arguments: servicesModel[index],
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
              color: AppColors.backgroundColor,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                servicesModel[index].title!,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                '${servicesModel[index].price!}EGP',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.hintTextColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 90.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                      255,
                                      174,
                                      119,
                                      194,
                                    ),
                                    elevation: 0,
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50.w, 30.h),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).push(
                                      MaterialPageRoute(
                                        builder: (context) => BookingService(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Book',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.backgroundColor,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppColors.backgroundColor,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            servicesModel[index].photo!,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
