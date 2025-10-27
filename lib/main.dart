import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/screens/login_screen.dart';
import 'package:taskify/features/auth/screens/signup_screen.dart';
import 'package:taskify/features/bookings/screens/booking_screen.dart';
import 'package:taskify/features/layout/screens/layout_screen.dart';
import 'package:taskify/features/onboarding/screens/user_type_screen.dart';
import 'package:taskify/features/provider_services/screens/provider_add_service_screen.dart';
import 'package:taskify/features/services/screens/services_screen.dart';
import 'package:taskify/features/splash/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: Project_URL,
    anonKey:
        API_KEY,
  );
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            fontFamily: 'Inter',
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Taskify app',
          initialRoute: splashScreenRoute,
          routes: {
            splashScreenRoute: (context) => const SplashScreen(),
            userTypeScreenRoute: (context) => const UserTypeScreen(),
            loginScreenRoute: (context) => const AuthLogin(),
            registerScreenRoute: (context) => const SignUpScreen(),
            layoutScreenRoute: (context) => const LayoutScreen(),
            servicesScreenRoute: (context) => ServicesScreen(),
            bookingScreenRoute: (context) => BookingScreen(),
            addServiceScreenRoute: (context) => ProviderAddServiceScreen(),
            // bookserviceRoute: (context) => BookingService(),
            // bookingDetailsScreenRoute: (context) =>  BookingDetails(bookingdeatils: BookingModel(),),
          },
        );
      },
    );
  }
}
