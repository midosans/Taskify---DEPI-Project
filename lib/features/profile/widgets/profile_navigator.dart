import 'package:flutter/material.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/profile/screens/edit_profile_screen.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';

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
        }
        return null;
      },
    );
  }
}
