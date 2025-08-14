import 'package:flutter/material.dart';
import 'package:latexquiz_rubizcode/core/constants/app_colors.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBackPressed;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  const AppBarDefault({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.white,
      backgroundColor: AppColors.white,
      leadingWidth: onBackPressed != null ? 56 : 16,
      titleSpacing: 0,
      centerTitle: true,

      leading: onBackPressed != null
          ? GestureDetector(
              onTap: () => onBackPressed?.call(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 24,
                color: AppColors.black,
              ),
            )
          : SizedBox(),
      title: Padding(
        padding: const EdgeInsets.only(left: 0),
        child: Text(title.toUpperCase(), style: AppTextStyles.appBarTitleTS),
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
