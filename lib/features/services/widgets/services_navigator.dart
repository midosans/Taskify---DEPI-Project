import 'package:flutter/material.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/services/data/services_model.dart';
import 'package:taskify/features/services/screens/services_screen.dart';
import 'package:taskify/features/services/screens/tasks_screen.dart';

class ServicesNavigator extends StatelessWidget {
  const ServicesNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: servicesScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == servicesScreenRoute) {
          return MaterialPageRoute(builder: (context) => ServicesScreen());
        } else if (settings.name == tasksScreenRoute) {
          final service = settings.arguments as ServicesModel;
          return MaterialPageRoute(
            builder: (context) => TasksScreen(servicesModel: service),
          );
        }
        return null;
      },
    );
  }
}
