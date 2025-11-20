import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/provider_services/cubit/add_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/delete_service_cubit.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_cubit.dart';
import 'package:taskify/features/provider_services/cubit/update_service_cubit.dart';
import 'package:taskify/features/provider_services/data/add_service_repo.dart';
import 'package:taskify/features/provider_services/data/delete_service_repo.dart';
import 'package:taskify/features/provider_services/data/provider_services_model.dart';
import 'package:taskify/features/provider_services/data/provider_services_repo.dart';
import 'package:taskify/features/provider_services/data/update_service_repo.dart';
import 'package:taskify/features/provider_services/screens/provider_add_service_screen.dart';
import 'package:taskify/features/provider_services/screens/provider_service_details.dart';
import 'package:taskify/features/provider_services/screens/provider_services_screen.dart';
import 'package:taskify/features/provider_services/screens/provider_update_service_screen.dart';

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
                  create:
                      (context) => ProviderServicesCubit(
                        providerServicesRepo: ProviderServicesRepo(),
                      )..fetchData(),
                  child: ProviderServicesScreen(),
                ),
          );
        } else if (settings.name == providerServiceDetailsRoute) {
          final service = settings.arguments as ProviderServicesModel;
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create: (context) => DeleteServiceCubit(deleteServiceRepo: DeleteServiceRepo()),
                  child: ProviderServiceDetails(servicesModel: service),
                ),
          );
        } else if (settings.name == addServiceScreenRoute) {
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) =>
                          AddServiceCubit(addServiceRepo: AddServiceRepo()),
                  child: ProviderAddServiceScreen(),
                ),
          );
        }else if (settings.name == updateServiceRoute) {
          final service = settings.arguments as ProviderServicesModel;
          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) =>
                          UpdateServiceCubit(updateServiceRepo: UpdateServiceRepo()),
                  child: ProviderUpdateServiceScreen(servicesModel: service,),
                ),
          );
        }
        return null;
      },
    );
  }
}
