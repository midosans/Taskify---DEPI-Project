import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_cubit.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';
import 'package:taskify/features/provider_services/data/provider_services_repo.dart';
import 'package:taskify/features/provider_services/screens/provider_service_details.dart';
import 'package:taskify/features/provider_services/screens/provider_services_screen.dart';

class ProviderServicesNavigator extends StatelessWidget {
  const ProviderServicesNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: providerServicesScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == providerServicesScreenRoute) {
          return MaterialPageRoute(
            builder:
                (_) => BlocProvider(
                  create: (context) => ProviderServicesCubit(providerServicesRepo: ProviderServicesRepo())..fetchData(),
                  child: ProviderServicesScreens(),
                ),
          );
        } else if (settings.name == providerServiceDetailsRoute) {
          final service = settings.arguments as ProviderServicesModel;
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
