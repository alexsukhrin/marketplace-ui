import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeftSection extends StatelessWidget {
  final String imagePath;

  const LeftSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Logo
          Positioned(
            top: 16,
            left: 16,
            child: Image.asset(
              'assets/images/logo_desktop.png',
              width: 48,
              height: 69,
              fit: BoxFit.contain,
            ),
          ),
          // Dynamic Image
          Center(
            child: SvgPicture.asset(
              imagePath,
              width: 631,
              height: 620,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
