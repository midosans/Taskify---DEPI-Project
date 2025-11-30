import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_app_button.dart';
import 'package:taskify/core/widgets/custom_error.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/home/cubit/home_cubit.dart';
import 'package:taskify/features/home/cubit/home_state.dart';
import 'package:taskify/features/home/widgets/custom_list_tile_home.dart';
import 'package:taskify/features/home/widgets/custom_loading_home.dart';
import 'package:taskify/features/home/widgets/home_grid_view.dart';
import 'package:taskify/features/home/widgets/no_booking_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.onGoToServices,
    required this.onGoToBookings,
    required this.onOpenTask,
    required this.onOpenBook,
  });

  final VoidCallback onGoToServices;
  final VoidCallback onGoToBookings;
  final void Function(String category) onOpenTask;
  final void Function(BookingModel bookingModel) onOpenBook;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'assets/pngs/slider1.png',
    'assets/pngs/slider2.png',
    'assets/pngs/slider3.png',
    'assets/pngs/slider4.png',
  ];

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeCubit>().getUpcomingBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        centerTitle: true,
        title: Text(
          'Taskify',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blackTextColor,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Carousel
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  height: 160.h,
                  viewportFraction: 1,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    setState(() => pageIndex = index);
                  },
                ),
                items: List.generate(images.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.3,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        child: DotsIndicator(
                          dotsCount: images.length,
                          position: pageIndex.toDouble(),
                          decorator: DotsDecorator(
                            spacing: EdgeInsets.symmetric(horizontal: 4.w),
                            size: Size(24.w, 6.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            activeSize: Size(24.w, 6.h),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            color: Colors.grey,
                            activeColor: AppColors.backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 10.h),
              // Services Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'services'.tr(),
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackTextColor,
                          ),
                        ),
                        Text(
                          'choose_service'.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.greyTextColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomAppButton(
                      onPressed: widget.onGoToServices,
                      text: 'view_all',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              //Home Grid (pass onOpenTask)
              HomeGridView(onOpenTask: widget.onOpenTask),
              SizedBox(height: 10.h),
              //Bookings Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      'bookings'.tr(),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    const Spacer(),
                    CustomAppButton(
                      onPressed: widget.onGoToBookings,
                      text: 'view_all',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // Bookings List (scrolls independently)
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return SizedBox(
                      height: 185.h,
                      child: const Center(child: CustomLoadingHome()),
                    );
                  } else if (state is HomeFailure) {
                    return Center(
                      child: CustomError(
                        subtitle: state.errorMessage.tr(),
                        onRefresh: () {
                          context.read<HomeCubit>().getUpcomingBookings();
                        },
                      ),
                    );
                  } else if (state is HomeSuccess) {
                    if (state.bookings.isEmpty) {
                      return NoBookingsCard(
                        onExploreServices: widget.onGoToServices,
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        // Call both refresh functions when pulling down
                        context.read<HomeCubit>().getUpcomingBookings();
                      },

                      // Needed so RefreshIndicator works even if list is short
                      notificationPredicate: (_) => true,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: SizedBox(
                          height: 185.h,
                          child: ListView.builder(
                            itemCount: state.bookings.length,
                            itemBuilder: (context, index) {
                              final booking = state.bookings[index];
                              final imageUrl = booking.imageUrl ?? '';
                              final titleText =
                                  booking.serviceTitle ??
                                  booking.providerName ??
                                  '';
                              return InkWell(
                                onTap: () => widget.onOpenBook(booking),
                                child: CustomListTileHome(
                                  imageUrl: imageUrl,
                                  titleText: titleText,
                                  status: booking.status,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
