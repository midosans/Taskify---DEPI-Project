import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDottedBorder extends StatelessWidget {
  final List<Widget> children;
  const CustomDottedBorder({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DottedBorder(
      color: Colors.grey,
      strokeWidth: 1,
      dashPattern: [5, 4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      child: Container(
        width: size.width * 0.9,
        height: 168.h,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var child in children) child,
            ],
          ),
        ),
      ),
    );
  }
}
