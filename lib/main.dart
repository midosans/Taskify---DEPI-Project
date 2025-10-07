import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/screens/login_screen.dart';
import 'package:taskify/features/auth/screens/signup_screen.dart';
import 'package:taskify/features/layout/screens/layout_screen.dart';
import 'package:taskify/features/services/screens/services_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
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
          theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'Inter',),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Taskify app',
          initialRoute: loginScreenRoute,
          routes: {
            loginScreenRoute: (context) => const AuthLogin(),
            registerScreenRoute: (context) => const SignUpScreen(),
            layoutScreenRoute: (context) => const LayoutScreen(),
            servicesScreenRoute: (context) => const ServicesScreen(),
          },
        );
      },
    );
  }
}
