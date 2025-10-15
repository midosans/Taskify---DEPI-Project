import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/services/data/categories_model.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});
  final List<CategoriesModel> categories = [
    CategoriesModel(
      name: 'ac_technician',
      image: 'assets/pngs/AC_technician_photo.png',
    ),
    CategoriesModel(name: 'plumber', image: 'assets/pngs/plumber_photo.png'),
    CategoriesModel(
      name: 'electrician',
      image: 'assets/pngs/electrician_photo.png',
    ),
    CategoriesModel(
      name: 'carpenter',
      image: 'assets/pngs/carpenter_photo.png',
    ),
    CategoriesModel(name: 'painter', image: 'assets/pngs/painter_photo.png'),
    CategoriesModel(
      name: 'tv_repair',
      image: 'assets/pngs/tv_repair_photo.png',
    ),
    CategoriesModel(name: 'cleaner', image: 'assets/pngs/cleaner_photo.png'),
    CategoriesModel(name: 'mechanic', image: 'assets/pngs/mechanic_photo.png'),
    CategoriesModel(
      name: 'glass_worker',
      image: 'assets/pngs/glass_worker_photo.png',
    ),
    CategoriesModel(
      name: 'internet_technician',
      image: 'assets/pngs/internet_technician_photo.png',
    ),
    CategoriesModel(
      name: 'satellite_technician',
      image: 'assets/pngs/satellite_technician_photo.png',
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
          'services'.tr(),
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Choose a Service',
            //   style: TextStyle(
            //     fontSize: 25.sp,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            // const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.93,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final s = categories[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        tasksScreenRoute,
                        arguments: s,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.asset(
                            s.image,
                            width: double.infinity,
                            height: 145.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          s.name.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
