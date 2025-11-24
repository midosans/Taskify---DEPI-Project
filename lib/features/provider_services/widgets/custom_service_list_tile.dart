import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class CustomServiceListTile extends StatelessWidget {
  const CustomServiceListTile({
    super.key,
    required this.service,
    this.onTap,
  });

  final ProviderServicesModel service;
  final VoidCallback? onTap; // optional callback

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap, // use the callback if provided
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.category ?? '',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    Text(
                      service.title ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      service.description ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    Text(
                      '\$${service.price?.toStringAsFixed(2) ?? ''}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF0F2F5),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(70.w, 30.h),
                      ),
                      onPressed: onTap,
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
                  ],
                ),
              ),
              Skeleton.leaf(
                child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CustomCashedImage(
                  url: service.photo ?? '',
                  size: const Size(130, 130),
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:taskify/core/app_colors.dart';
// import 'package:taskify/core/constants.dart';
// import 'package:taskify/core/widgets/custom_cashed_image.dart';
// import 'package:taskify/features/provider_services/data/provider_services_model.dart';

// class CustomServiceListTile extends StatelessWidget {
//   const CustomServiceListTile({super.key, required this.service});
//   final ProviderServicesModel service;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8.r),
//         onTap:
//             () => Navigator.pushNamed(
//               context,
//               providerServiceDetailsRoute,
//               arguments: service,
//             ),
//         child: Container(
//           // height: 130.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.r),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       service.category ?? '',
//                       style: TextStyle(fontSize: 14.sp, color: Colors.grey),
//                     ),
//                     Text(
//                       service.title ?? '',
//                       style: TextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       service.description ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontSize: 14.sp, color: Colors.grey),
//                     ),
//                     Text(
//                       '\$${service.price?.toStringAsFixed(2) ?? ''}',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 4.h),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xffF0F2F5),
//                         elevation: 0,
//                         padding: EdgeInsets.zero,
//                         minimumSize: Size(80.w, 30.h),
//                       ),
//                       onPressed:
//                           () => Navigator.pushNamed(
//                             context,
//                             providerServiceDetailsRoute,
//                             arguments: service,
//                           ),
//                       child: Center(
//                         child: Text(
//                           'view_details'.tr(),
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: AppColors.blackTextColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8.r),
//                 child:CustomCashedImage(url: service.photo!, size: Size(130,130))
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// //130w 150h