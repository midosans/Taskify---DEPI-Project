import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/features/profile/screens/weight.dart';

import '../../../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Others",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                CircleAvatar(
                radius: 60.r,
                          backgroundImage: AssetImage("assets/pngs/profile.png"),
                        ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ethan Carter",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      )),
                    SizedBox(height: 6.h),
                      Text("+1 (555) 123-4567",
                      style: TextStyle(
                        fontSize: 15.sp
                      ),)
                    ]
                  ),
                ),

    ]),
            SizedBox(height: 30.h,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    foregroundColor:Colors.black26,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),

                    )
                  ),
                  child: Text("Edit Profile",
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold
                  ),
                  )),
            ),
            SizedBox(height: 28.h,),



            buildSettingsItem(
              icon: Icons.language,
              title: "Language",
              onTap: () {},
            ),
            buildSettingsItem(
              icon: Icons.help_outline,
              title: "Contact Us",
              onTap: () {},
            ),
            buildSettingsItem(
              icon: Icons.info_outline,
              title: "About App",
              onTap: () {},
            ),
            buildSettingsItem(
              icon: Icons.description_outlined,
              title: "Terms & Conditions",
              onTap: () {},
            ),
            buildSettingsItem(
              icon: Icons.logout,
              title: "Logout",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }


}



