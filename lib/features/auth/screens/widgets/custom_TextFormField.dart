import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/features/auth/screens/widgets/custom_obsecure_icon.dart';

class CustomTextformfield extends StatefulWidget {
  final String labelText;
  final String? prefixIconPath;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

   const CustomTextformfield({
    super.key,
    required this.labelText,
    this.prefixIconPath,
    this.isObscureText,
    this.suffixIcon,
    this.controller,
  });

  @override
  State<CustomTextformfield> createState() => _CustomTextformfieldState();
}

class _CustomTextformfieldState extends State<CustomTextformfield> {
  final formkey = GlobalKey<FormState>();
  late bool isObscureText;
  void initState() {
    super.initState();
    isObscureText = widget.isObscureText ?? false;
  }

  void toggleObscureText() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formkey,
      obscureText: isObscureText,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: AppColors.primaryColor),
      decoration: InputDecoration(
        fillColor: AppColors.whiteTextColor,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.prefixIconPath != null?
                   SvgPicture.asset(
            widget.prefixIconPath!,
            width: 24,
            height: 24) : null,
        ),
        suffixIcon:
            (widget.isObscureText ?? false)
                ? CustomObsecureIcon(
                  isObscure: isObscureText,
                  toggle: toggleObscureText,
                )
                : widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500,fontSize: 16.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        
      ),
    );
  }
}
