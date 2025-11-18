import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_button.dart';
import 'package:taskify/core/widgets/custom_cashed_image.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/features/provider_services/cubit/delete_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/delete_service_state.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';

class ProviderServiceDetails extends StatelessWidget {
  final ProviderServicesModel servicesModel;

  const ProviderServiceDetails({super.key, required this.servicesModel});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final cubit = context.read<DeleteServiceCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          servicesModel.title ?? '',
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

      body: BlocListener<DeleteServiceCubit, DeleteServiceState>(
        listener: (context, state) async {
          if (state is DeleteServiceLoading) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              useRootNavigator: true,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is DeleteServiceSuccess) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "Service Deleted",
                    subtitle: "Your service has been successfully removed.",
                    buttontext: "OK",
                    icon: Icons.check_circle,
                  ),
            ).then((_) {
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            });
          } else if (state is DeleteServiceFailure) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (!context.mounted) return;

            showDialog(
              context: context,
              builder:
                  (_) => CustomNotifyDialog(
                    title: "Error",
                    subtitle: state.errorMessage,
                    buttontext: "OK",
                    icon: Icons.error,
                  ),
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomCashedImage(
                    url: servicesModel.photo!,
                    size: Size(double.infinity, 250.h),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            servicesModel.title ?? '',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              '${'price'.tr()}: ${servicesModel.price ?? ''} ${'egp'.tr()}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            servicesModel.description ?? '',
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
            SizedBox(
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    CustomButton(
                      text: 'edit_service'.tr(),
                      size: Size(size.width, 50.h),
                      color: AppColors.primaryColor,
                      fontColor: AppColors.whiteTextColor,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          updateServiceRoute,
                          arguments: servicesModel,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    CustomButton(
                      text: 'delete_service'.tr(),
                      size: Size(size.width, 50.h),
                      color: AppColors.deleteColor,
                      fontColor: AppColors.whiteTextColor,
                      onPressed: () {
                        context.showBlocDialog(
                          cubit: cubit,
                          dialog: CustomConfirmDialog(
                            title: "Delete Service",
                            subtitle:
                                "Are you sure you want to Delete ${servicesModel.title}?",
                            buttontext: "Delete",
                            onConfirm: () {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(); // closes the dialog
                              cubit.deleteService(id: servicesModel.id!);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
