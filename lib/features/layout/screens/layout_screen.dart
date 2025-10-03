import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/screens/booking_screen.dart';
import 'package:taskify/features/home/screens/home_screen.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';
import 'package:taskify/features/services/screens/services_screen.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  List<Widget> screens = [
    HomeScreen(),
    ServicesScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.blackTextColor,
        unselectedItemColor: AppColors.secondaryColor,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/home.svg'),
            label: 'home'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/home_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/services.svg'),
            label: 'services'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/services_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/booking.svg'),
            label: 'bookings'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/booking_active.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/svgs/profile.svg'),
            label: 'profile'.tr(),
            activeIcon: SvgPicture.asset('assets/svgs/profile_active.svg'),
          ),
        ],
      ),
    );
  }
}
