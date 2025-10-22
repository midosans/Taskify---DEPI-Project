import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.centerLeft,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Text(
        title.tr(),
        style: TextStyle(
          fontSize: 25.sp,
          color: Color(0xff6E179C),
          fontWeight: FontWeight.bold,
          //fontFamily: ''
        ),
      ),
    );
  }
}
