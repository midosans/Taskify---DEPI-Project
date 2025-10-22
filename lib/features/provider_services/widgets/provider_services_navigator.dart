import 'package:flutter/material.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/provider_services/screens/provider_service_details.dart';
import 'package:taskify/features/provider_services/screens/provider_services_screen.dart';
import 'package:taskify/features/services/data/services_model.dart';

class ProviderServicesNavigator extends StatelessWidget {
  const ProviderServicesNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: providerServicesScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == providerServicesScreenRoute) {
          return MaterialPageRoute(
            builder: (context) => ProviderServicesScreens(),
          );
        } else if (settings.name == providerServiceDetailsRoute) {
          final service = settings.arguments as ServicesModel;
          return MaterialPageRoute(
            builder:
                (context) => ProviderServiceDetails(servicesModel: service),
          );
        }
        return null;
      },
    );
  }
}
