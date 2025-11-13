import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/cubit/bookings_cubit.dart';
import 'package:taskify/features/bookings/cubit/bookings_state.dart';
import 'package:taskify/features/bookings/data/booking_repo.dart';
import 'package:taskify/features/bookings/screens/bookings_tab.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BookingsCubit _bookingsCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _bookingsCubit = BookingsCubit(bookingRepo: BookingRepo());

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _bookingsCubit.fetchForTab(_tabController.index);
      }
    });

    _bookingsCubit.fetchForTab(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bookingsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bookingsCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'bookings'.tr(),
            style: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.blackTextColor,
            labelStyle: TextStyle(
                fontSize: 13.sp, fontWeight: FontWeight.w600),
            unselectedLabelColor: AppColors.lightprimarycolor,
            indicatorColor: AppColors.blackTextColor,
            indicatorWeight: 1,
            tabs: [
              Tab(text: 'all'.tr()),
              Tab(text: 'completed'.tr()),
              Tab(text: 'upcoming'.tr()),
              Tab(text: 'cancelled'.tr()),
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(4, (index) {
            return BlocBuilder<BookingsCubit, BookingState>(
              builder: (context, state) {
                if (state is BookingLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookingError) {
                  return Center(child: Text(state.message));
                } else if (state is BookingEmpty) {
                  return Center(child: Text('No bookings yet'));
                } else if (state is BookingSuccess) {
                  if (state.bookings.isEmpty) {
                    return Center(child: Text('No bookings yet'));
                  }
                  return AllBookingsTab(bookings: state.bookings, tabIndex: index,);
                }
                return const SizedBox.shrink();
              },
            );
          }),
        ),
      ),
    );
  }
}
