import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/core/app_colors.dart';
import 'package:taskify/core/widgets/custom_obsecure_icon.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String? prefixIconPath;
  final IconData? prefixIcon;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.prefixIconPath,
    this.isObscureText,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final formkey = GlobalKey<FormState>();
  late bool isObscureText;
  @override
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
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      key: formkey,
      obscureText: isObscureText,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteTextColor,
        prefixIcon:
            widget.prefixIconPath != null
                ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    widget.prefixIconPath!,
                    width: 18.w,
                    height: 18.h,
                  ),
                )
                : (widget.prefixIcon != null
                    ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        widget.prefixIcon,
                        color: AppColors.primaryColor,
                      ),
                    )
                    : null),
        suffixIcon:
            (widget.isObscureText ?? false)
                ? CustomObsecureIcon(
                  isObscure: isObscureText,
                  toggle: toggleObscureText,
                )
                : widget.suffixIcon,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
          borderRadius: BorderRadius.circular(10.r),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightprimarycolor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),

      autovalidateMode: AutovalidateMode.onUserInteraction,

      validator: (textValue) {
        if (textValue == null || textValue.isEmpty) {
          return 'required!';
        }
        return null;
      },
    );
  }
}
