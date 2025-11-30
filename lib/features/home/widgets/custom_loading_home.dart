import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskify/features/home/widgets/custom_list_tile_home.dart';

class CustomLoadingHome extends StatelessWidget {
  const CustomLoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomListTileHome(imageUrl: '', titleText: '', status: ''),
          ),
        ),
      ),
    );
  }
}
