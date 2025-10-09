import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/services/data/services_model.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});

  final List<ServicesModel> services = [
    ServicesModel(
      category: 'AC Technician',
      photo: 'assets/pngs/AC_technician_photo.png',
    ),
    ServicesModel(category: 'Plumber', photo: 'assets/pngs/plumber_photo.png'),
    ServicesModel(
      category: 'Electrician',
      photo: 'assets/pngs/electrician_photo.png',
    ),
    ServicesModel(
      category: 'TV Repair',
      photo: 'assets/pngs/tv_repair_photo.png',
    ),
    ServicesModel(
      category: 'Carpenter',
      photo: 'assets/pngs/carpenter_photo.png',
    ),
    ServicesModel(category: 'Painter', photo: 'assets/pngs/painter_photo.png'),
    ServicesModel(category: 'Cleaner', photo: 'assets/pngs/cleaner_photo.png'),
    ServicesModel(
      category: 'Mechanic',
      photo: 'assets/pngs/mechanic_photo.png',
    ),
    ServicesModel(
      category: 'Glass Worker',
      photo: 'assets/pngs/glass_worker_photo.png',
    ),
    ServicesModel(
      category: 'Internet Technician',
      photo: 'assets/pngs/internet_technician_photo.png',
    ),
    ServicesModel(
      category: 'Satellite Technician',
      photo: 'assets/pngs/satellite_technician_photo.png',
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
          'Services',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  childAspectRatio: 0.95,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final s = services[index];
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
                            s.photo,
                            width: double.infinity,
                            height: 145.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          s.category,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
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
