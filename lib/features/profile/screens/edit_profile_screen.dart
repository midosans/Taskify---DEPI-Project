import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/profile/screens/profile_screen.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/custom_TextFormField.dart';
import '../../../core/widgets/custom_button.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   TextEditingController usernameController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Form(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 110.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image:  DecorationImage(
                              image: AssetImage('assets/pngs/Depth 5, Frame 0.png'),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color:  AppColors.primaryColor,
                              width: 3.w,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding:  EdgeInsets.all(4),
                            decoration:  BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child:  Icon(Icons.edit, color: AppColors.backgroundColor, size: 18),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 16.h),
                     Text(
                      'Sophia Carter',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),

             Text(
              'Username',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
             SizedBox(height: 8.h),
            CustomTextFormField(labelText: 'Enter your username',controller:usernameController ,),
             SizedBox(height:30.h),

             Text(
              'Phone Number',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
             SizedBox(height: 8.h),
            CustomTextFormField(labelText: 'Enter your phone number',controller:phoneController ,),
             SizedBox(height: 30.h),

             Text(
              'Password',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
             SizedBox(height: 8.h),
            CustomTextFormField(labelText: 'Enter your password',controller:passwordController ,isObscureText: true,),

             SizedBox(height: 60.h),

             CustomButton(
    text: "Save Changes",
    size: Size(size.width.w, 48.h),
    color: AppColors.primaryColor,
    fontColor: AppColors.whiteTextColor,
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>  ProfileScreen()),
            (route) => false,
      );



    },
    ),




          ],
        ),
      ),
    );
  }
}
