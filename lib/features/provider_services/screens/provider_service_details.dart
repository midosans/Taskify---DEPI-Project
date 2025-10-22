import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class ProviderServiceDetails extends StatelessWidget {
  const ProviderServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {

          },
        ),
        title: const Text(
          'Service Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/pngs/Depth 4, Frame 0.png',
              height: 250.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

             Padding(
              padding:  EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                   Text(
                    'Interior Design Consultation',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                   SizedBox(height: 8.h),

                   Text(
                    'Price: \$75',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                   SizedBox(height: 16.h),

                   Text(
                    "Transform your living space with expert advice. Our interior design consultation service offers personalized guidance to help you achieve your dream home aesthetic. We'll discuss your style preferences, budget, and spatial needs to create a cohesive and functional design plan.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.5.r,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

             SizedBox(height: 24.h),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(text: 'Edit Service', size: Size(double.infinity, 50.h),  fontColor: AppColors.whiteTextColor, color: AppColors.primaryColor,),


             SizedBox(height: 12.h)   ,
            CustomButton(text: 'Delete Service', size: Size(double.infinity, 50.h),  fontColor: AppColors.whiteTextColor, color: AppColors.cancelcolor,)

          ],
        ),
      ),
    );
  }
}
