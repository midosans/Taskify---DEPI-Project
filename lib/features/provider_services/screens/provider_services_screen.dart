import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_cubit.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_state.dart';
import 'package:taskify/features/provider_services/widgets/custom_error_provider.dart';
import 'package:taskify/features/provider_services/widgets/custom_loading_service.dart';
import 'package:taskify/features/provider_services/widgets/custom_service_list_tile.dart';

class ProviderServicesScreen extends StatefulWidget {
  const ProviderServicesScreen({super.key});

  @override
  State<ProviderServicesScreen> createState() =>
      _ProviderServicesScreensState();
}

class _ProviderServicesScreensState extends State<ProviderServicesScreen> {
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
      body: RefreshIndicator(
        onRefresh: () async {
          // Call both refresh functions when pulling down
          context.read<ProviderServicesCubit>().fetchData();
        },

        // Needed so RefreshIndicator works even if list is short
        notificationPredicate: (_) => true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.h),
          child: BlocBuilder<ProviderServicesCubit, ProviderServicesState>(
            builder: (context, state) {
              if (state is ProviderServicesLoading) {
                return const Center(child: CustomLoadingService());
              } else if (state is ProviderServicesFailure) {
                return CustomErrorProvider(subtitle: state.errorMessage.tr(), onRefresh: (){
                  context.read<ProviderServicesCubit>().fetchData();
                });
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
                  return CustomServiceListTile(
                    service: service,
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        providerServiceDetailsRoute,
                        arguments: service,
                      );
        
                      // 🔄 Refresh the list when returning from details screen
                      if (result == true && context.mounted) {
                        await Future.delayed(const Duration(milliseconds: 300)); // optional small delay
                        context.read<ProviderServicesCubit>().fetchData();
                      }
                    },
                  );
                },
              );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50.h,
        width: 140.w,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              addServiceScreenRoute,
            );

            // When AddServiceScreen returns true, refresh the list
            if (result == true && context.mounted) {
              context.read<ProviderServicesCubit>().fetchData();
            }
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
