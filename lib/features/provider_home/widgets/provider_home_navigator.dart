import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/provider_home/cubit/fetch_accepted_bookings_cubit.dart';
import 'package:taskify/features/provider_home/cubit/fetch_pending_bookings_cubit.dart';
import 'package:taskify/features/provider_home/cubit/update_booking_cubit.dart';
import 'package:taskify/features/provider_home/data/fetch_booking_repo.dart';
import 'package:taskify/features/provider_home/data/update_booking_repo.dart';
import 'package:taskify/features/provider_home/screens/provider_booking_details.dart';
import 'package:taskify/features/provider_home/screens/provider_home_screen.dart';

class ProviderHomeNavigator extends StatelessWidget {
  const ProviderHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: providerhomeScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == providerhomeScreenRoute) {
          return MaterialPageRoute(
            builder:
                (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create:
                          (_) => FetchPendingBookingsCubit(
                            repo: FetchBookingRepo(),
                          ),
                    ),
                    BlocProvider(
                      create:
                          (_) => FetchAcceptedBookingsCubit(
                            repo: FetchBookingRepo(),
                          ),
                    ),
                  ],
                  child: const ProviderHomeScreen(),
                ),
          );
        } else if (settings.name == providerBookingDetailsRoute) {
          final book = settings.arguments as BookingModel;
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) => UpdateBookingCubit(
                        repo: UpdateBookingRepo(),
                      ),
                  child: ProviderBookingDetails(bookingdeatils: book),
                ),
          );
        }
        return null;
      },
    );
  }
}
