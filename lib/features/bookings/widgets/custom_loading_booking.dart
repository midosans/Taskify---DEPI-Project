import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/app_services/booking_fake.dart';
import 'package:taskify/features/bookings/widgets/custom_tile.dart';

class CustomLoadingBooking extends StatelessWidget {
  const CustomLoadingBooking({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomTile(service: BookingFake.fake()),
          ),
        ),
      ),
    );
  }
}


