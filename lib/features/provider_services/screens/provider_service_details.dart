import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
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

class ProviderServiceDetails extends StatefulWidget {
  final ProviderServicesModel servicesModel;

  const ProviderServiceDetails({super.key, required this.servicesModel});

  @override
  State<ProviderServiceDetails> createState() => _ProviderServiceDetailsState();
}

class _ProviderServiceDetailsState extends State<ProviderServiceDetails> {
  Color _iconColor = Colors.white;
  Color _titleColor = Colors.white;
  bool _collapsed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _updateAppBarColor();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final collapsePoint = 250.h - kToolbarHeight;
    final isCollapsed = _scrollController.offset > collapsePoint;

    if (isCollapsed != _collapsed) {
      setState(() {
        _collapsed = isCollapsed;
      });
    }
  }

  Future<void> _updateAppBarColor() async {
    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.servicesModel.photo!),
        size: Size(200, 100),
      );

      final dominant = paletteGenerator.dominantColor?.color ?? Colors.black;
      if (mounted) {
        setState(() {
          _iconColor =
              dominant.computeLuminance() > 0.6 ? Colors.black : Colors.white;
          _titleColor =
              dominant.computeLuminance() > 0.6 ? Colors.black : Colors.white;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _iconColor = Colors.white;
          _titleColor = Colors.white;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeleteServiceCubit>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                    title: "service_deleted_title".tr(),
                    subtitle: "service_deleted_subtitle".tr(),
                    buttontext: "ok".tr(),
                    icon: Icons.check_circle,
                  ),
            ).then((_) {
              if (context.mounted) Navigator.of(context).pop(true);
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
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.h,
                  pinned: true,
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: AppColors.backgroundColor,
                  surfaceTintColor: AppColors.backgroundColor,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: _collapsed ? Colors.black : _iconColor,
                      size: 22.sp,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: _collapsed ? Colors.black : _titleColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Text(widget.servicesModel.title ?? ''),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomCashedImage(
                      url: widget.servicesModel.photo!,
                      size: Size(double.infinity, 250.h),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.servicesModel.title ?? '',
                          style: TextStyle(
                            fontSize: 24.sp,
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
                          widget.servicesModel.description ??
                              'No description available.',
                          //'i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.i am a test description to check if the description field works properly in the service details screen.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.4,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
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
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      text: 'edit_service'.tr(),
                      size: Size(double.infinity, 50.h),
                      color: AppColors.primaryColor,
                      fontColor: AppColors.whiteTextColor,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          updateServiceRoute,
                          arguments: widget.servicesModel,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    CustomButton(
                      text: 'delete_service'.tr(),
                      size: Size(double.infinity, 50.h),
                      color: AppColors.deleteColor,
                      fontColor: AppColors.whiteTextColor,
                      onPressed: () {
                        context.showBlocDialog(
                          cubit: cubit,
                          dialog: CustomConfirmDialog(
                            title: "delete_service_title".tr(),
                            subtitle: "delete_service_subtitle".tr(
                              args: [widget.servicesModel.title!],
                            ),
                            buttontext: "delete".tr(),
                            onConfirm: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              cubit.deleteService(id: widget.servicesModel.id!);
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
