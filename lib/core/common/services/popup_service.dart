import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:latexquiz_rubizcode/core/constants/app_colors.dart';
import 'package:latexquiz_rubizcode/core/constants/app_sizes.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';
import 'package:latexquiz_rubizcode/main.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

showInfo({String? title, required String message}) {
  // EasyLoading.instance.indicatorSize = 28;
  // EasyLoading.instance.backgroundColor = AppColors.primaryColor;
  // EasyLoading.showInfo(message);
  final context = globalNavigatorKey.currentContext;
  if (context != null) {
    showTopSnackBar(
      Overlay.of(context),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      Container(
        height: 68,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: Colors.blue.shade800, // Translucent color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          color: Colors.blue.shade50,
          height: 68,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kGapL,
              Icon(Icons.info, color: Colors.blue.shade800, size: 28),
              kGapL,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "Info",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeTS.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    kGapXS,
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleTS.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      displayDuration: const Duration(seconds: 2),
    );
  }
}

showLoading({String? message}) {
  EasyLoading.instance.indicatorSize = 40;
  EasyLoading.instance.backgroundColor = Colors.black;
  EasyLoading.show(status: message);
}

dismissLoading() {
  EasyLoading.dismiss();
}

showSuccess({String? title, required String message}) {
  // EasyLoading.instance.indicatorSize = 32;
  // EasyLoading.instance.backgroundColor = Colors.green.shade700;
  //EasyLoading.showSuccess(message);
  final context = globalNavigatorKey.currentContext;
  if (context != null) {
    showTopSnackBar(
      Overlay.of(context),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      Container(
        height: 68,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: AppColors.green, // Translucent color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          color: Colors.yellow.shade50,
          height: 68,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kGapL,
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              kGapL,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "Success",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeTS.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    kGapXS,
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleTS.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      displayDuration: const Duration(seconds: 2),
    );
  }
}

showError({
  String? title,
  String? message,
}) {
  // EasyLoading.instance.indicatorSize = 32;
  // EasyLoading.instance.backgroundColor = Colors.red.shade700;
  // EasyLoading.showError(message!);
  final context = globalNavigatorKey.currentContext;
  if (context != null) {
 //   final errorTitle = error?.response?.data['message'] as String?;
   // final errorData = error?.response?.data['data'] as Map<String, dynamic>?;

    showTopSnackBar(
      Overlay.of(context),
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      Container(
        height: 68,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: AppColors.red, // Translucent color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          color: Colors.red.shade50,
          height: 68,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kGapL,
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white, size: 22),
              ),
              kGapL,
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "Error",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleLargeTS.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    kGapXS,
                    Text(
                      message ?? 'Something went wrong' ,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.titleTS.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      displayDuration: const Duration(seconds: 2),
    );
  }
}
