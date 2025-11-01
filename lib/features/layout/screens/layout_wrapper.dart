import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/bookings/cubit/bookings_cubit.dart';
import 'package:taskify/features/home/cubit/home_cubit.dart';
import 'package:taskify/features/layout/screens/layout_screen.dart';
import 'package:taskify/features/profile/cubit/profile_cubit.dart';
import 'package:taskify/features/provider_services/cubit/provider_services_cubit.dart';
import 'package:taskify/features/services/cubit/services_cubit.dart';

class LayoutWrapper extends StatelessWidget {
  final String userType;

  const LayoutWrapper({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    // debugPrint('🔍 User Type: $userType');

    // Choose Cubits based on user type
    final providers = <BlocProvider>[
      BlocProvider(create: (_) => ProfileCubit()),
    ];

    if (userType == "User") {
      providers.addAll([
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ServicesCubit()),
        BlocProvider(create: (_) => BookingsCubit()),
      ]);
    } else {
      providers.addAll([
        BlocProvider(create: (_) => ProviderServicesCubit()),
        // Maybe a cubit for technician home, etc.
      ]);
    }

    return MultiBlocProvider(
      providers: providers,
      child: LayoutScreen(userType: userType),
    );
  }
}
