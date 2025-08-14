// import 'package:flutter/material.dart';
// import 'package:lifeintheuk/core/constants/app_colors.dart';
// import 'package:lifeintheuk/core/constants/app_sizes.dart';
// import 'package:lifeintheuk/core/constants/app_text_styles.dart';
// import 'package:lifeintheuk/core/constants/asset_const.dart';
// import 'package:go_router/go_router.dart';

// class SuccessDialogWidget extends StatelessWidget {
//   final String title;
//   final String message;
//   final Function()? onClose;
//   const SuccessDialogWidget({
//     super.key,
//     required this.title,
//     required this.message,
//     this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           alignment: Alignment.center,
//           margin: const EdgeInsets.fromLTRB(32, 20, 32, 20),
//           padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),

//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       onClose != null ? onClose!() : context.pop();
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Icon(
//                         Icons.close,
//                         color: AppColors.blackSecondary400,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Image.asset(
//                 AssetConst.successIcon,
//                 height: 110,
//                 width: 110,
//                 fit: BoxFit.fill,
//               ),
//               kGapL,
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.titleLargeTS.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               kGapM,
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyles.infoTSBlack400.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
