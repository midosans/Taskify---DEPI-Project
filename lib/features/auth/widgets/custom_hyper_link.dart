import 'package:flutter/material.dart';
import 'package:taskify/core/app_colors.dart';

class CustomHyperLink extends StatelessWidget {
  final String title;
  final String link;
  final VoidCallback? onPressed;
  const CustomHyperLink({
    super.key,
    required this.title,
    required this.link,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        GestureDetector(
          onTap: onPressed ?? () {},
          child: Text(link, style: TextStyle(color: AppColors.primaryColor)),
        ),
      ],
    );
  }
}
