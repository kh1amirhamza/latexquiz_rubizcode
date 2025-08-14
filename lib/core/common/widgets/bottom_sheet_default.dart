import 'package:flutter/material.dart';
import 'package:latexquiz_rubizcode/core/constants/app_sizes.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';

import '../../constants/app_colors.dart';

class BottomSheetDefault extends StatelessWidget {
  final String title;
  final Widget child;
  final double paddingBottom;
  const BottomSheetDefault({
    super.key,
    required this.title,
    required this.child,
    this.paddingBottom = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        top: 9,
        left: 16,
        right: 16,
        bottom: paddingBottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3,
            width: 83,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: AppColors.activeIconColor,
            ),
          ),
          kGapM,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: AppTextStyles.titleTS),
          ),
          kGapXL,
          Flexible(fit: FlexFit.loose, child: child),
        ],
      ),
    );
  }
}
