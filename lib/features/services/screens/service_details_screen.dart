import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
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
  Color _iconColor = Colors.white;
  Color _titleColor = Colors.white;
  bool _collapsed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().getPhone(
      providerId: widget.servicesModel.providerid!,
    );
    _analyzeImageBrightness();
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

  Future<void> _analyzeImageBrightness() async {
    try {
      final networkImage = NetworkImage(widget.servicesModel.photo ?? '');
      final completer = Completer<ImageInfo>();
      final stream = networkImage.resolve(const ImageConfiguration());
      final listener = ImageStreamListener(
        (info, _) {
          if (!completer.isCompleted) completer.complete(info);
        },
        onError: (error, _) {
          if (!completer.isCompleted) completer.completeError(error);
        },
      );

      stream.addListener(listener);
      final imageInfo = await completer.future;
      stream.removeListener(listener);

      final palette = await PaletteGenerator.fromImage(imageInfo.image);
      final dominantColor = palette.dominantColor?.color ?? Colors.black;
      final brightness = ThemeData.estimateBrightnessForColor(dominantColor);

      if (mounted) {
        setState(() {
          _iconColor =
              brightness == Brightness.dark ? Colors.white : Colors.black;
          _titleColor =
              brightness == Brightness.dark ? Colors.white : Colors.black;
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
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
                    url: widget.servicesModel.photo ?? 'assets/pngs/error.png',
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
                        widget.servicesModel.description ??
                            'No description available.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.4,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                      SizedBox(height: 135.h),
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
