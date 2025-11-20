import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/services/cubit/services_cubit.dart';
import 'package:taskify/features/services/data/categories_model.dart';
import 'package:taskify/features/services/data/services_model.dart';
import 'package:taskify/features/services/data/services_repo.dart';
import 'package:taskify/features/services/screens/categories_screen.dart';
import 'package:taskify/features/services/screens/service_details_screen.dart';
import 'package:taskify/features/services/screens/services_screen.dart';

class ServicesNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> servicesNavigatorKey;
  const ServicesNavigator({super.key, required this.servicesNavigatorKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: servicesNavigatorKey,
      initialRoute: categoriesScreenRoute,
      onGenerateRoute: (settings) {
        if (settings.name == categoriesScreenRoute) {
          return MaterialPageRoute(builder: (context) => CategoriesScreen());
        } else if (settings.name == servicesScreenRoute) {
          final arg = settings.arguments;
          CategoriesModel? category;
          if (arg is CategoriesModel) {
            category = arg;
          } else if (arg is String) {
            category = CategoriesModel(name: arg, image: '');
          }

          if (category == null) return null;

          return MaterialPageRoute(
            builder:
                (context) => BlocProvider(
                  create:
                      (context) =>
                          ServicesCubit(servicesRepo: ServicesRepo())
                            ..getServices(category: category!.name),
                  child: ServicesScreen(category: category!),
                ),
          );
        } else if (settings.name == serviceDetailsScreenRoute) {
          final service = settings.arguments as ServicesModel;
          return MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(servicesModel: service),
          );
        }
        return null;
      },
    );
  }
}
