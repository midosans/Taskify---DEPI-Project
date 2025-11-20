import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/bookings/screens/booking_service.dart';
import 'package:taskify/features/services/cubit/services_cubit.dart';
import 'package:taskify/features/services/cubit/services_state.dart';
import 'package:taskify/features/services/data/categories_model.dart';

class ServicesScreen extends StatefulWidget {
  final CategoriesModel category;
  const ServicesScreen({super.key, required this.category});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final categoryName =
  //       ModalRoute.of(context)!.settings.arguments as CategoriesModel;
  //   // context.read<ServicesCubit>().getServices(category: categoryName);
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ServicesCubit>().getServices(category: widget.category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          widget.category.name.tr(),
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
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoadig) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServicesFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(fontSize: 16.sp, color: Colors.red),
              ),
            );
          } else if (state is ServicesSuccess) {
            if (state.services.isEmpty) {
              return Center(
                child: Text(
                  'no_services_found'.tr(),
                  style: TextStyle(fontSize: 18.sp),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      serviceDetailsScreenRoute,
                      arguments: state.services[index],
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
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
                                      state.services[index].title!,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      '${state.services[index].price!}EGP',
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
                                              builder: (context) => BookingService(
                                                serviceModel: state.services[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 5.w),
                                            Text(
                                              'book'.tr(),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                color:
                                                    AppColors.backgroundColor,
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
                                // child: CachedNetworkImage(
                                //  imageUrl: state.services[index].photo!,
                                //   width: 100.w,
                                //   height: 100.h,
                                //   fit: BoxFit.cover,
                                //   placeholder: (context, url) =>
                                //       const CircularProgressIndicator(),
                                //   errorWidget: (context, url, error) =>
                                //       const Icon(Icons.error),
                                // ),
                                child: CustomCashedImage(
                                  url: state.services[index].photo!,
                                  size: Size(100, 100),
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
