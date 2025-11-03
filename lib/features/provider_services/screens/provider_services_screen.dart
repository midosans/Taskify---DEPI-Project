import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_cubit.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_state.dart';
import 'package:taskify/features/provider_services/screens/provider_add_service_screen.dart';
import 'package:taskify/features/provider_services/widgets/custom_service_list_tile.dart';

class ProviderServicesScreens extends StatelessWidget {
  const ProviderServicesScreens({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child: BlocBuilder<ProviderServicesCubit, ProviderServicesState>(
          builder: (context, state) {
            if (state is ProviderServicesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProviderServicesFailure) {
              return Center(child: Text(state.errorMessage));
            } else if (state is ProviderServicesSuccess) {
              final services = state.providerServicesdata;
              debugPrint(services.isEmpty.toString());
              if (services.isEmpty) {
                return const Center(child: Text("You don't have any service"));
              }

              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return CustomServiceListTile(service: service,);
                },
              );
            } else {
              debugPrint(state.toString());
              return const SizedBox();
            }
          },
        ),
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
