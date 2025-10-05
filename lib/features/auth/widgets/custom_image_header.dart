import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.3,
        child: Image.asset('assets/pngs/logo.png'),
      ),
    );
  }
}
