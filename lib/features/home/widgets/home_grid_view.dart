import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/home/widgets/home_service_container.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 3.25,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        HomeServiceContainer(
          icon: 'assets/svgs/AC_technician_icon.svg',
          title: 'ac_technician',
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/plumber_icon.svg',
          title: 'plumber',
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/electrician_icon.svg',
          title: 'electrician',
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/TV_repair_icon.svg',
          title: 'tv_repair',
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/carpenter_icon.svg',
          title: 'carpenter',
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/painter_icon.svg',
          title: 'painter',
        ),
      ],
    );
  }
}
