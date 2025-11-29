import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_error.dart';
import 'package:taskify/core/widgets/custom_no_data.dart';
import 'package:taskify/features/services/cubit/services_cubit.dart';
import 'package:taskify/features/services/cubit/services_state.dart';
import 'package:taskify/features/services/data/categories_model.dart';
import 'package:taskify/features/services/widgets/custom_list_tile_service.dart';
import 'package:taskify/features/services/widgets/custom_loading_service_user.dart';

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
            return Center(child: CustomLoadingServiceUser());
          } else if (state is ServicesFailure) {
            return Center(
              child: CustomError(
                subtitle: state.errorMessage.tr(),
                onRefresh: () async {
                  context.read<ServicesCubit>().getServices(
                        category: widget.category.name,
                      );
                },)
            );
          } else if (state is ServicesSuccess) {
            if (state.services.isEmpty) {
              return Center(
                child: CustomNoData(
                  title: 'no_services_available'.tr(),
                  subtitle: 'please_check_back_later'.tr(),
                  onRefresh: () async {
                    context.read<ServicesCubit>().getServices(
                          category: widget.category.name,
                        );
                  },
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                // Call both refresh functions when pulling down
                context.read<ServicesCubit>().getServices(
                  category: widget.category.name,
                );
              },

              // Needed so RefreshIndicator works even if list is short
              notificationPredicate: (_) => true,
              child: ListView.builder(
                itemCount: state.services.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        serviceDetailsScreenRoute,
                        arguments: state.services[index],
                      );
                    },
                    child: CustomListTileService(
                      service: state.services[index],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
