import 'package:flutter/material.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/profile/screens/edit_profile_screen.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';
import 'package:taskify/features/profile/screens/contact_screen.dart';
import 'package:taskify/features/profile/screens/about_app_screen.dart';
import 'package:taskify/features/profile/screens/terms_conditions_screen.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: profileScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == profileScreenRoute) {
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        } else if (settings.name == editProfileScreenRoute) {
          return MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          );
        } else if (settings.name == contactScreenRoute) {
          return MaterialPageRoute(builder: (context) => const ContactScreen());
        } else if (settings.name == aboutAppScreenRoute) {
          return MaterialPageRoute(
            builder: (context) => const AboutAppScreen(),
          );
        } else if (settings.name == termsConditionsScreenRoute) {
          return MaterialPageRoute(
            builder: (context) => const TermsConditionsScreen(),
          );
        }
        return null;
      },
    );
  }
}
