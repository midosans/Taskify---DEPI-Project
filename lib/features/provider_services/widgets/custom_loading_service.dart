import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/app_services/provider_service_fake.dart';
import 'package:taskify/features/provider_services/widgets/custom_service_list_tile.dart';

class CustomLoadingService extends StatelessWidget {
  const CustomLoadingService({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomServiceListTile(
              service: ServiceFake.fake(),
            ),
          ),
        ),
      ),
    );
  }
}


