import 'package:flutter/material.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/screens/booking_details.dart';
import 'package:taskify/features/bookings/screens/booking_screen.dart';
import 'package:taskify/features/bookings/screens/booking_service.dart';

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
            builder: (context) => BookingDetails(bookingdeatils: book),
          );
        } else if (settings.name == bookserviceRoute) {
          return MaterialPageRoute(builder: (context) => BookingService());
        }
        return null;
      },
    );
  }
}
