import 'package:flutter/material.dart';
import 'package:latexquiz_rubizcode/core/constants/app_colors.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';

class ButtonDefault extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  const ButtonDefault({
    super.key,
    required this.title,
    this.onPressed,
    this.height,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: width,
      height: height,
      disabledColor: (backgroundColor ?? AppColors.primaryColor).withAlpha(127),
      color: backgroundColor ?? AppColors.primaryColor,
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Text(title, style: AppTextStyles.btnLargeTS.copyWith(color: textColor, fontSize: fontSize)),
    );
  }

  factory ButtonDefault.expanded({
    required String title,
    final Function()? onPressed,
    double? height,
    double? width,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    return ButtonDefault(
      title: title,
      onPressed: onPressed,
      width: double.infinity,
      height: height,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
