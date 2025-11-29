import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/app_services/user_service_fake.dart';
import 'package:taskify/features/services/widgets/custom_list_tile_service.dart';

class CustomLoadingServiceUser extends StatelessWidget {
  const CustomLoadingServiceUser({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomListTileService(service: UserServiceFake.fake()),
          ),
        ),
      ),
    );
  }
}


