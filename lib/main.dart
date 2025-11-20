import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/app_services/bloc_observer.dart';
import 'package:taskify/core/api_helper.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/auth/screens/forgot_password_screen.dart';
import 'package:taskify/features/auth/cubit/login_cubit.dart';
import 'package:taskify/features/auth/cubit/signup_cubit.dart';
import 'package:taskify/features/auth/data/login_repo.dart';
import 'package:taskify/features/auth/data/signup_repo.dart';
import 'package:taskify/features/auth/screens/login_screen.dart';
import 'package:taskify/features/auth/screens/reset_password_screen.dart';
import 'package:taskify/features/auth/screens/signup_screen.dart';
import 'package:taskify/features/auth/screens/verify_code_screen.dart';
import 'package:taskify/features/bookings/screens/booking_screen.dart';
import 'package:taskify/features/layout/screens/layout_wrapper.dart';
import 'package:taskify/features/onboarding/screens/user_type_screen.dart';
import 'package:taskify/features/profile/screens/about_app_screen.dart';
import 'package:taskify/features/profile/screens/contact_screen.dart';
import 'package:taskify/features/profile/screens/terms_conditions_screen.dart';
import 'package:taskify/features/provider_services/screens/provider_add_service_screen.dart';
import 'package:taskify/features/services/screens/categories_screen.dart';
import 'package:taskify/features/splash/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(url: Project_URL, anonKey: API_KEY);
  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: const MyApp(),
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

          onGenerateRoute: (settings) {
            switch (settings.name) {
              case splashScreenRoute:
                return MaterialPageRoute(builder: (_) => const SplashScreen());
              case userTypeScreenRoute:
                return MaterialPageRoute(
                  builder: (_) => const UserTypeScreen(),
                );
              case loginScreenRoute:
                return MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => LoginCubit(loginRepo: LoginRepo()),
                        child: AuthLogin(),
                      ),
                );
              case registerScreenRoute:
                final userType = settings.arguments as String?;
                return MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => SignupCubit(signupRepo: SignupRepo()),
                        child: SignUpScreen(userType: userType),
                      ),
                );
              case layoutWrapperRoute:
                final userType = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => LayoutWrapper(userType: userType),
                );
              // case layoutScreenRoute:
              //   return MaterialPageRoute(builder: (_) => const LayoutScreen());
              case categoriesScreenRoute:
                return MaterialPageRoute(builder: (_) => CategoriesScreen());
              
              case addServiceScreenRoute:
                return MaterialPageRoute(
                  builder: (_) => ProviderAddServiceScreen(),
                );
              case forgotPasswordScreenRoute:
                return MaterialPageRoute(
                  builder: (context) => const ForgotPasswordScreen(),
                );
              case verifyCodeScreenRoute:
                // final args =
                //     ModalRoute.of(context)!.settings.arguments as String;
                return MaterialPageRoute(
                  builder: (_) => VerifyCodeScreen(),
                );
              case resetPasswordScreenRoute:
                return MaterialPageRoute(builder: (_) => ResetPasswordScreen(
                ));
                case contactScreenRoute:
                return MaterialPageRoute(builder: (_) => ContactScreen());
                case aboutAppScreenRoute:
                return MaterialPageRoute(builder: (_) => AboutAppScreen());
                case termsConditionsScreenRoute:
                return MaterialPageRoute(builder: (_) => TermsConditionsScreen());
              default:
                return null;
            }
          },
        );
      },
    );
  }
}
