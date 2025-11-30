import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_app_button.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/features/services/cubit/contact_cubit.dart';
import 'package:taskify/features/services/cubit/contact_state.dart';
import 'package:taskify/features/services/data/services_model.dart';
import 'package:taskify/features/services/widgets/launcher_helper.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final ServicesModel servicesModel;

  const ServiceDetailsScreen({super.key, required this.servicesModel});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getPhone(
      providerId: widget.servicesModel.providerid!,
    );
    // _analyzeImageBrightness();
    // _scrollController.addListener(_scrollListener);
  }

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
          widget.servicesModel.title ?? '',
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
                  url: widget.servicesModel.photo ?? 'assets/pngs/error.png',
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
                          widget.servicesModel.title ?? '',
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
                            '${'price'.tr()}: ${widget.servicesModel.price ?? ''} ${'egp'.tr()}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.hintTextColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          widget.servicesModel.description ?? '',
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, -2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<ContactCubit, ContactState>(
                    builder: (context, state) {
                      String avatar = 'assets/pngs/profile.png';
                      String phone = '';
                      if (state is ContactSuccess) {
                        avatar =
                            state.contactModel.avatar ??
                            'assets/pngs/profile.png';
                        phone = state.contactModel.phone;
                      }
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 28.r,
                            child:
                                state is ContactLoading
                                    ? const CircularProgressIndicator(
                                      strokeWidth: 2,
                                    )
                                    : ClipOval(
                                      child:
                                          avatar == 'assets/pngs/profile.png'
                                              ? Image.asset(
                                                avatar,
                                                width: 56.r,
                                                height: 56.r,
                                                fit: BoxFit.cover,
                                              )
                                              : CustomCashedImage(
                                                url: avatar,
                                                size: Size(56.r, 56.r),
                                                fit: BoxFit.cover,
                                              ),
                                    ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.servicesModel.providername ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  widget.servicesModel.category?.tr() ?? '',
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
                          CustomAppButton(
                            onPressed: () {
                              if (state is ContactSuccess) {
                                LauncherHelper.openDialer(phone);
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
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  CustomAppButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        bookserviceRoute,
                        arguments: widget.servicesModel,
                      );
                    },
                    text: 'book_now'.tr(),
                    size: Size(double.infinity, 48.h),
                    isBuld: true,
                    fontSize: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
