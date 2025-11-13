import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/features/profile/cubit/profile_cubit.dart';
import 'package:taskify/features/profile/cubit/profile_state.dart';
import 'package:taskify/features/profile/data/logout_repo.dart';
import 'package:taskify/features/profile/widgets/build_settings_item.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void changeLanguage() {
    setState(() {
      if (context.locale == const Locale('en')) {
        context.setLocale(const Locale('ar'));
      } else {
        context.setLocale(const Locale('en'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()
        ..fetchUserData(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return Center(
                        child: CircularProgressIndicator(),);
                    }
                    else if (state is ProfileError) {
                      return Center(
                        child: Text('${state.errorMessage}'),
                      );
                    }
                    else if (state is ProfileLoaded) {
                      final userData = state.userdataModel;
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: const AssetImage(
                              "assets/pngs/profile.png",
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userData.name,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  userData.phone,
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black26,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'edit_profile'.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.h),
                BuildSettingsItem(
                  icon: Icons.language,
                  title: 'language'.tr(),
                  onTap: changeLanguage,
                ),
                BuildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'contact_us'.tr(),
                  onTap: () {},
                ),
                BuildSettingsItem(
                  icon: Icons.info_outline,
                  title: 'about_app'.tr(),
                  onTap: () {},
                ),
                BuildSettingsItem(
                  icon: Icons.description_outlined,
                  title: 'terms_conditions'.tr(),
                  onTap: () {},
                ),
                BuildSettingsItem(
                  icon: Icons.logout,
                  title: 'logout'.tr(),
                  onTap: () async {
                    await LogoutRepo().signOut();

                    print('Navigating to: $userTypeScreenRoute'); // debug

                    Navigator.of(
                      context,
                      rootNavigator: true,
                    ).pushNamedAndRemoveUntil(
                      userTypeScreenRoute,
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
