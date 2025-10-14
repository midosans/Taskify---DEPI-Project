import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.25, 
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), 
            child: Image.asset(
              'assets/pngs/logo.png',
              fit: BoxFit.contain, 
            ),
          ),
        ),
      ),
    );
  }
}
