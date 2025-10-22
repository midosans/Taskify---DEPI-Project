import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/bookings/widgets/booking_navigator.dart';
import 'package:taskify/features/home/screens/home_screen.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';
import 'package:taskify/features/provider_home/screens/provider_home_screen.dart';
import 'package:taskify/features/provider_services/widgets/provider_services_navigator.dart';
import 'package:taskify/features/services/widgets/services_navigator.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late List<Widget> screens = [];
  int currentIndex = 0;
  String? userType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userType = ModalRoute.of(context)?.settings.arguments as String?;

    if (userType == "Technician") {
      screens = [
         ProviderHomeScreen(),
        const ProviderServicesNavigator(),
        const ProfileScreen(),
      ];
    } else {
      screens = [
        HomeScreen(
          onGoToServices: () => setState(() => currentIndex = 1),
          onGoToBookings: () => setState(() => currentIndex = 2),
        ),
        const ServicesNavigator(),
        const BookingNavigator(),
        const ProfileScreen(),
      ];
    }

    debugPrint('User type: $userType');
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isTechnician = userType == "Technician";
    final locale = context.locale;

    return Scaffold(
      body: screens.isNotEmpty ? screens[currentIndex] : const SizedBox(),
      bottomNavigationBar: BottomNavigationBar(
        key: ValueKey(locale.languageCode),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.blackTextColor,
        unselectedItemColor: AppColors.secondaryColor,
        onTap: (index) => setState(() => currentIndex = index),
        items:
            isTechnician
                ? [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/home.svg'),
                    label: 'home'.tr(),
                    activeIcon: SvgPicture.asset('assets/svgs/home_active.svg'),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/services.svg'),
                    label: 'my_services'.tr(),
                    activeIcon: SvgPicture.asset(
                      'assets/svgs/services_active.svg',
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/profile.svg'),
                    label: 'profile'.tr(),
                    activeIcon: SvgPicture.asset(
                      'assets/svgs/profile_active.svg',
                    ),
                  ),
                ]
                : [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/home.svg'),
                    label: 'home'.tr(),
                    activeIcon: SvgPicture.asset('assets/svgs/home_active.svg'),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/services.svg'),
                    label: 'services'.tr(),
                    activeIcon: SvgPicture.asset(
                      'assets/svgs/services_active.svg',
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/booking.svg'),
                    label: 'bookings'.tr(),
                    activeIcon: SvgPicture.asset(
                      'assets/svgs/booking_active.svg',
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/svgs/profile.svg'),
                    label: 'profile'.tr(),
                    activeIcon: SvgPicture.asset(
                      'assets/svgs/profile_active.svg',
                    ),
                  ),
                ],
      ),
    );
  }
}
