import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomIcon extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Color color;
  final double size;
  final FontWeight weight;
  const CustomIcon({
    this.icon,
    this.title,
    this.color = AppColors.primaryColor,
    this.size = 20,
    this.weight = FontWeight.w800,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? String.fromCharCode(icon!.codePoint),
      style: TextStyle(
        inherit: false,
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontFamily: Icons.space_dashboard_outlined.fontFamily,
      ),
    );
  }
}
