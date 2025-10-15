import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Size size;
  final Color color;
  final Color fontColor;
  final String? iconPath;
  final VoidCallback? onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontColor,
    this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: size,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconPath != null
              ? SvgPicture.asset(iconPath!, width: 24, height: 24)
              : SizedBox(),
          SizedBox(width: iconPath != null ? 10.w : 0),
          Text(
            text,
            style: TextStyle(
              color: fontColor,
              fontWeight: FontWeight.w900,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
