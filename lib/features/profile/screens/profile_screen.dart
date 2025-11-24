import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/features/profile/cubit/profile_cubit.dart';
import 'package:taskify/features/profile/cubit/profile_state.dart';
import 'package:taskify/features/profile/data/logout_repo.dart';
import 'package:taskify/features/profile/data/user_data_model.dart';
import 'package:taskify/features/profile/widgets/build_settings_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserdataModel? _userData;

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
      create: (context) => ProfileCubit()..fetchUserData(),
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
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProfileError) {
                      return Center(child: Text('${state.errorMessage}'));
                    } else if (state is ProfileLoaded) {
                      _userData = state.userdataModel;

                      final userData = _userData!;

                      return Row(
                        children: [
                          userData.avatar != null
                              ? CircleAvatar(
                                radius: 60.r,
                                backgroundImage: CachedNetworkImageProvider(
                                  userData.avatar!,
                                ),
                              )
                              : CircleAvatar(
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
                      if (_userData == null) return;

                      Navigator.pushNamed(
                        context,
                        editProfileScreenRoute,
                        arguments: _userData!, // ← now works
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
                  onTap: () {
                    Navigator.pushNamed(context, contactScreenRoute);
                  },
                ),
                BuildSettingsItem(
                  icon: Icons.info_outline,
                  title: 'about_app'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, aboutAppScreenRoute);
                  },
                ),
                BuildSettingsItem(
                  icon: Icons.description_outlined,
                  title: 'terms_conditions'.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, termsConditionsScreenRoute);
                  },
                ),
                BuildSettingsItem(
                  icon: Icons.logout,
                  title: 'logout'.tr(),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomConfirmDialog(
                          title: 'Logout',
                          subtitle: "do you want to logout from your account ?",
                          buttontext: "Logout",
                          onConfirm: () async {
                            await LogoutRepo().signOut();

                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamedAndRemoveUntil(
                              userTypeScreenRoute,
                              (route) => false,
                            );
                          },
                        );
                      },
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
