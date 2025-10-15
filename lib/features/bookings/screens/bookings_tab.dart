import 'package:flutter/material.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/screens/booking_details.dart';
import 'package:taskify/features/bookings/widgets/custom_tile.dart';

class AllBookingsTab extends StatelessWidget {
  final List<BookingModel> bookings;
  const AllBookingsTab({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: CustomTile(service: bookings[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        BookingDetails(bookingdeatils: bookings[index]),
              ),
            );
          },
        );
      },
    );
  }
}
