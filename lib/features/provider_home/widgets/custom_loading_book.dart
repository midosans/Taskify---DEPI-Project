import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/app_services/booking_fake.dart';
import 'package:taskify/features/provider_home/widgets/custom_list_tile_for_provider.dart';

class CustomLoadingBook extends StatelessWidget {
  const CustomLoadingBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomListTileForProvider(
              service: BookingFake.fake(), // <-- fake placeholder model
            ),
          ),
        ),
      ),
    );
  }
}


