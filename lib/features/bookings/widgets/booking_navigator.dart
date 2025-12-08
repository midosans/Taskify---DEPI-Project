import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/bookings/cubit/delete_booking_cubit.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/data/delete_booking_repo.dart';
import 'package:taskify/features/bookings/screens/booking_details.dart';
import 'package:taskify/features/bookings/screens/booking_screen.dart';
import 'package:taskify/features/services/cubit/contact_cubit.dart';
import 'package:taskify/features/services/data/contact_repo.dart';

class BookingNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> bookingNavigatorKey;
  const BookingNavigator({super.key, required this.bookingNavigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: bookingNavigatorKey,
      initialRoute: bookingScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == bookingScreenRoute) {
          return MaterialPageRoute(builder: (context) => BookingScreen());
        } else if (settings.name == bookingDetailsScreenRoute) {
          final book = settings.arguments as BookingModel;
          return MaterialPageRoute(
            builder:
                (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create:
                          (context) => ContactCubit(contactRepo: ContactRepo()),
                    ),
                    BlocProvider(
                      create:
                          (context) => DeleteBookingCubit(deleteBookingRepo: DeleteBookingRepo()),
                    ),
                  ],
                  child: BookingDetails(bookingdeatils: book),
                ),
          );
        }
        return null;
      },
    );
  }
}
