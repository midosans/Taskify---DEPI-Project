import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/home/widgets/home_service_container.dart';

class HomeGridView extends StatelessWidget {
  const HomeGridView({
    super.key, required this.onOpenTask,
  });

  final void Function(String category) onOpenTask;
  
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
          onTap: () => onOpenTask('AC Technician'),
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/plumber_icon.svg',
          title: 'plumber',
          onTap: () => onOpenTask('Plumber'),
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/electrician_icon.svg',
          title: 'electrician',
          onTap: () => onOpenTask('Electrician'),
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/TV_repair_icon.svg',
          title: 'tv_repair',
          onTap: () => onOpenTask('TV Repair'),
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/carpenter_icon.svg',
          title: 'carpenter',
          onTap: () => onOpenTask('Carpenter'),
        ),
        HomeServiceContainer(
          icon: 'assets/svgs/painter_icon.svg',
          title: 'painter',
          onTap: () => onOpenTask('Painter'),
        ),
      ],
    );
  }
}
