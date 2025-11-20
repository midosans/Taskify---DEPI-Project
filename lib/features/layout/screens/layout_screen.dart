import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/bookings/data/booking_model.dart';
import 'package:taskify/features/bookings/widgets/booking_navigator.dart';
import 'package:taskify/features/home/cubit/home_cubit.dart';
import 'package:taskify/features/home/data/home_repo.dart';
import 'package:taskify/features/home/screens/home_screen.dart';
import 'package:taskify/features/profile/widgets/profile_navigator.dart';
import 'package:taskify/features/provider_home/screens/provider_home_screen.dart';
import 'package:taskify/features/provider_services/widgets/provider_services_navigator.dart';
import 'package:taskify/features/services/widgets/services_navigator.dart';

final GlobalKey<NavigatorState> servicesNavigatorKey =
    GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> bookingNavigatorKey =
    GlobalKey<NavigatorState>();

class LayoutScreen extends StatefulWidget {
  final String userType;
  const LayoutScreen({super.key, required this.userType});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late List<Widget> screens;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final userType = widget.userType;

    if (userType == "User") {
      screens = [
        BlocProvider(
          create: (context) => HomeCubit(homeRepo: HomeRepo()),
          child: HomeScreen(
            onGoToServices: () => setState(() => currentIndex = 1),
            onGoToBookings: () => setState(() => currentIndex = 2),
            onOpenTask: (String category) {
              // Push first before switching tab
              servicesNavigatorKey.currentState?.pushNamed(
                servicesScreenRoute,
                arguments: category,
              );
              // Slightly delay tab change to avoid visible GridView flash
              Future.delayed(Duration(milliseconds: 50), () {
                setState(() => currentIndex = 1);
              });
            },
            onOpenBook: (BookingModel bookingModel) {
              // Push first before switching tab
              bookingNavigatorKey.currentState?.pushNamed(
                bookingDetailsScreenRoute,
                arguments: bookingModel,
              );
              // Slightly delay tab change to avoid visible GridView flash
              Future.delayed(Duration(milliseconds: 50), () {
                setState(() => currentIndex = 2);
              });
            },
          ),
        ),
        ServicesNavigator(servicesNavigatorKey: servicesNavigatorKey),
        BookingNavigator(bookingNavigatorKey: bookingNavigatorKey),
        const ProfileNavigator(),
      ];
    } else {
      screens = [
        ProviderHomeScreen(),
        const ProviderServicesNavigator(),
        const ProfileNavigator(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final isUser = widget.userType == "User";

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        key: ValueKey(locale.languageCode),
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.blackTextColor,
        unselectedItemColor: AppColors.secondaryColor,
        items:
            isUser
                ? [
                  _navItem('home', 'home'),
                  _navItem('services', 'services'),
                  _navItem('bookings', 'booking'),
                  _navItem('profile', 'profile'),
                ]
                : [
                  _navItem('home', 'home'),
                  _navItem('my_services', 'services'),
                  _navItem('profile', 'profile'),
                ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(String labelKey, String iconName) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset('assets/svgs/$iconName.svg'),
      activeIcon: SvgPicture.asset('assets/svgs/${iconName}_active.svg'),
      label: labelKey.tr(),
    );
  }
}
