import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/bookings/cubit/bookings_state.dart';
import 'package:taskify/features/bookings/cubit/bookings_cubit.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/screens/booking_details.dart';
import 'package:taskify/features/bookings/widgets/custom_tile.dart';
import 'package:taskify/features/provider_home/widgets/custom_loading_book.dart';
import 'package:taskify/features/services/cubit/contact_cubit.dart';
import 'package:taskify/features/services/data/contact_repo.dart';

class AllBookingsTab extends StatelessWidget {
  final int tabIndex;
  const AllBookingsTab({
    super.key,
    required this.tabIndex,
    required List<BookingModel> bookings,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingLoading) {
          return const Center(child: CustomLoadingBook());
        } else if (state is BookingError) {
          return Center(child: Text(state.message));
        } else if (state is BookingEmpty) {
          return const Center(child: Text('No bookings yet'));
        } else if (state is BookingSuccess) {
          if (state.bookings.isEmpty) {
            return const Center(child: Text('No bookings yet'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              // Call both refresh functions when pulling down
              context.read<BookingsCubit>().fetchForTab(tabIndex);
            },

            // Needed so RefreshIndicator works even if list is short
            notificationPredicate: (_) => true,
            child: ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final booking = state.bookings[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BlocProvider(
                              create:
                                  (context) =>
                                      ContactCubit(contactRepo: ContactRepo()),
                              child: BookingDetails(bookingdeatils: booking),
                            ),
                      ),
                    );
                  },
                  child: CustomTile(service: booking),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
