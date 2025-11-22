import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/app_services/dialog_extension.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_confirm_dialog.dart';
import 'package:taskify/core/widgets/custom_notify_dialog.dart';
import 'package:taskify/features/profile/cubit/update_profile_cubit.dart';
import 'package:taskify/features/profile/cubit/update_profile_state.dart';
import 'package:taskify/features/profile/data/user_data_model.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.userdataModel});
  final UserdataModel userdataModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  File? avatar;

  @override
  void initState() {
    super.initState();

    usernameController.text = widget.userdataModel.name;
    phoneController.text = widget.userdataModel.phone;
    passwordController.text = "";
  }

  @override
  void dispose() {
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> pickAvatar() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        avatar = File(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) async {
        if (state is UpdateProfileLoading) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          showDialog(
            context: context,
            barrierDismissible: false,
            useRootNavigator: true,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is UpdateProfileSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (!context.mounted) return;

          await showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (_) => CustomNotifyDialog(
                  title: "Profile Updated",
                  subtitle: "Your changes have been saved successfully.",
                  buttontext: "OK",
                  icon: Icons.check_circle,
                ),
          );

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
              (route) => false,
            );
          }
        } else if (state is UpdateProfileError) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (!context.mounted) return;

          showDialog(
            context: context,
            builder:
                (_) => CustomNotifyDialog(
                  title: "Error",
                  subtitle: state.errorMessage,
                  buttontext: "OK",
                  icon: Icons.error,
                ),
          );
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
            'edit_profile'.tr(),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.blackTextColor,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blackTextColor,
              size: 22.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 110.w,
                        height: 110.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image:
                                avatar != null
                                    ? FileImage(avatar!)
                                    : (widget.userdataModel.avatar != null &&
                                                widget
                                                    .userdataModel
                                                    .avatar!
                                                    .isNotEmpty
                                            ? NetworkImage(
                                              widget.userdataModel.avatar!,
                                            )
                                            : const AssetImage(
                                              'assets/pngs/profile.png',
                                            ))
                                        as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 3.w,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Material(
                          shape: const CircleBorder(),
                          color: AppColors.primaryColor,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: pickAvatar,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              Divider(thickness: 1.2),

              SizedBox(height: 18.h),

              _buildField(
                controller: usernameController,
                icon: Icons.person_outline,
                label: 'username'.tr(),
                hint: 'enter_new_username'.tr(),
              ),

              _buildField(
                controller: phoneController,
                icon: Icons.phone,
                keyboard: TextInputType.phone,
                label: 'phone_number'.tr(),
                hint: 'enter_new_phone_number'.tr(),
              ),

              _buildField(
                controller: passwordController,
                icon: Icons.lock_outline,
                label: 'password'.tr(),
                hint: 'enter_new_password'.tr(),
                obscure: true,
              ),

              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    if (usernameController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please complete all required fields"),
                        ),
                      );
                      return;
                    }

                    context.showBlocDialog(
                      cubit: context.read<UpdateProfileCubit>(),
                      dialog: CustomConfirmDialog(
                        title: "Update Profile",
                        subtitle:
                            "Are you sure you want to update your profile information?",
                        buttontext: "Update",
                        onConfirm: () {
                          // Close dialog
                          Navigator.of(context, rootNavigator: true).pop();

                          // Call update method
                          context.read<UpdateProfileCubit>().saveProfileChanges(
                            username: usernameController.text,
                            phone: phoneController.text,
                            newPassword: passwordController.text,
                            avatarFile: avatar,
                            role: widget.userdataModel.role,
                          );
                        },
                      ),
                    );
                  },

                  child: Text(
                    'save_changes'.tr(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    TextInputType? keyboard,
    bool obscure = false,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 18.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primaryColor),
            labelText: label,
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
