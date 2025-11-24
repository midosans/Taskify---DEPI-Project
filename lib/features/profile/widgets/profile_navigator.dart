import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/profile/cubit/update_profile_cubit.dart';
import 'package:taskify/features/profile/data/update_user_repo.dart';
import 'package:taskify/features/profile/data/user_data_model.dart';
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
          final UserdataModel args =
              settings.arguments as UserdataModel;
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) => UpdateProfileCubit(
                        updateProfileRepo : UpdateUserRepo(),
                      ),
                  child: EditProfileScreen(userdataModel: args),
                ),
          );
          // return MaterialPageRoute(
          //   builder: (context) => const EditProfileScreen(),
          // );
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
