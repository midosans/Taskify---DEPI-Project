import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SupabaseClient _client = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = _client.auth.currentUser;

    if (user == null) {
      Navigator.pushReplacementNamed(context, userTypeScreenRoute);
      return;
    }

    final profileResponse =
        await _client.from('profile').select().eq('id', user.id).maybeSingle();

    if (profileResponse == null) {
      Navigator.pushReplacementNamed(context, userTypeScreenRoute);
      return;
    }

    final role = profileResponse['role'] as String?;

    if (role == null || role.isEmpty) {
      Navigator.pushReplacementNamed(context, userTypeScreenRoute);
    } else if (role == 'User') {
      Navigator.pushNamedAndRemoveUntil(
        context,
        layoutWrapperRoute,
        (routes) => false,
        arguments: "customer",
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        layoutWrapperRoute,
        (routes) => false,
        arguments: 'Technician',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 200.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 150.h,
                child: Image.asset(
                  'assets/pngs/logo.png',
                  width: 125,
                  height: 125,
                ),
              ),
              SizedBox(
                width: 160.w,
                child: LinearProgressIndicator(
                  minHeight: 5.h,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
