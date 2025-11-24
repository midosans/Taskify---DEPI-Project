import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/provider_home/cubit/fetch_booking_data_state.dart';
import 'package:taskify/features/provider_home/cubit/fetch_pending_bookings_cubit.dart';
import 'package:taskify/features/provider_home/cubit/fetch_accepted_bookings_cubit.dart';
import 'package:taskify/features/provider_home/widgets/custom_list_tile_for_provider.dart';
import 'package:taskify/features/provider_home/widgets/custom_loading_book.dart';
import 'package:taskify/features/provider_home/widgets/custom_no_books.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchPendingBookingsCubit>().loadPending();
      context.read<FetchAcceptedBookingsCubit>().loadOngoing();
    });
  }

  @override
  Widget build(BuildContext context) {
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

      body: RefreshIndicator(
        onRefresh: () async {
          // Call both refresh functions when pulling down
          context.read<FetchPendingBookingsCubit>().loadPending();
          context.read<FetchAcceptedBookingsCubit>().loadOngoing();
        },

        // Needed so RefreshIndicator works even if list is short
        notificationPredicate: (_) => true,

        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // IMPORTANT
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "new_orders".tr(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ----- Pending Bookings -----
            BlocBuilder<FetchPendingBookingsCubit, FetchBookingDataState>(
              builder: (context, state) {
                if (state is FetchBookingDataLoading) {
                  return const SliverToBoxAdapter(child: CustomLoadingBook());
                }
                if (state is FetchBookingDataError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is FetchBookingDataEmpty) {
                  return SliverToBoxAdapter(
                    child: CustomNoBooks(
                      title: "no_new_orders".tr(),
                      subtitle: "please_check_back_later".tr(),
                      onRefresh: () {
                        context.read<FetchPendingBookingsCubit>().loadPending();
                      },
                    ),
                  );
                }
                if (state is FetchBookingDataSuccess) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => CustomListTileForProvider(
                        service: state.bookings[index],
                      ),
                      childCount: state.bookings.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),

            SliverToBoxAdapter(child: SizedBox(height: 20.h)),

            // ----- Ongoing Work -----
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "ongoing_work".tr(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            BlocBuilder<FetchAcceptedBookingsCubit, FetchBookingDataState>(
              builder: (context, state) {
                if (state is FetchBookingDataLoading) {
                  return const SliverToBoxAdapter(child: CustomLoadingBook());
                }
                if (state is FetchBookingDataError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                }
                if (state is FetchBookingDataEmpty) {
                  return SliverToBoxAdapter(
                    child: CustomNoBooks(
                      title: "no_new_orders".tr(),
                      subtitle: "please_check_back_later".tr(),
                      onRefresh: () {
                        context
                            .read<FetchAcceptedBookingsCubit>()
                            .loadOngoing();
                      },
                    ),
                  );
                }
                if (state is FetchBookingDataSuccess) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => CustomListTileForProvider(
                        service: state.bookings[index],
                      ),
                      childCount: state.bookings.length,
                    ),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox());
              },
            ),
          ],
        ),
      ),
    );
  }
}
