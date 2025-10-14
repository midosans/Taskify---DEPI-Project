import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/widgets/booking_navigator.dart';
import 'package:taskify/features/home/screens/home_screen.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';
import 'package:taskify/features/services/widgets/services_navigator.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(
        onGoToServices: () {
          setState(() {
            currentIndex = 1;
          });
        },
        onGoToBookings: () {
          setState(() {
            currentIndex = 2;
          });
        },
      ),
      const ServicesNavigator(),
      const BookingNavigator(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
