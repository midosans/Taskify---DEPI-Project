import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCashedImage extends StatelessWidget {
  const CustomCashedImage({super.key, required this.url, required this.size, this.fit});
  final String url;
  final Size size;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width.w,
      height: size.height.h,
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        imageUrl: url,
        placeholder:
            (context, url) => Container(
              width: size.width.w,
              height: size.height.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
        errorWidget:
            (context, url, error) => Image.asset(
              'assets/pngs/error.png',
              width: size.width.w,
              height: size.height.h,
              fit: BoxFit.cover,
            ),
      ),
    );
  }
}
