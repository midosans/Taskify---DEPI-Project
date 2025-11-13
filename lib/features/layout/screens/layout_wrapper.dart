import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/bookings/cubit/bookings_cubit.dart';
import 'package:taskify/features/bookings/data/booking_repo.dart';
import 'package:taskify/features/home/cubit/home_cubit.dart';
import 'package:taskify/features/layout/screens/layout_screen.dart';
import 'package:taskify/features/profile/cubit/profile_cubit.dart';
import 'package:taskify/features/services/cubit/services_cubit.dart';
import 'package:taskify/features/services/data/services_repo.dart';

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

    if (userType == "customer") {
      providers.addAll([
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => ServicesCubit()),
        BlocProvider(create: (_) => BookingsCubit(bookingRepo: BookingRepo())),
      ]);
    } 
    // else {
    //   providers.addAll([
    //     BlocProvider(create: (_) => ProviderServicesCubit()),
    //   ]);
    // }

    return MultiBlocProvider(
      providers: providers,
      child: LayoutScreen(userType: userType),
    );
  }
}
