// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:lifeintheuk/core/constants/app_sizes.dart';
// import 'package:lifeintheuk/core/constants/app_text_styles.dart';
// import 'package:lifeintheuk/core/constants/asset_const.dart';

// enum NotFoundType {
//   pro,
//   service,
//   task,
//   category,
//   order,
//   chat,
//   bid,
//   internet,
//   maintenance,
//   update,
//   earning,
//   taskHistory,
//   others,
// }

// class NotFoundWidget extends StatelessWidget {
//   final NotFoundType type;
//   final String? title;
//   final String? description;
//   const NotFoundWidget({super.key, this.type = NotFoundType.others, this.title, this.description});

//   @override
//   Widget build(BuildContext context) {
//      String imageAsset, titleString, des;

//     switch (type) {
//       case NotFoundType.pro:
//         {
//           imageAsset = AssetConst.workers;
//           titleString = "No Pro Found";
//           des = "No Pro found related to to this category in your area";
//         }
//       case NotFoundType.service:
//         {
//           imageAsset = AssetConst.notFound;
//           titleString = "No Service Found";
//           des =
//               "No Service found related to to this category in your area";
//         }
//       case NotFoundType.task:
//         {
//           imageAsset = AssetConst.noBids;
//           titleString = "No Task Found";
//           des =
//               "No task found, Create your task...";
//         }
//       case NotFoundType.category:
//         {
//           imageAsset = AssetConst.notFound;
//           titleString = "No Service Category Found";
//           des = "No Service Category found in your area";
//         }
//       case NotFoundType.order:
//         {
//           imageAsset = AssetConst.notFound;
//           titleString = "No Order Found";
//           des = "No Order found for you";
//         }
//       case NotFoundType.chat:
//         {
//           imageAsset = AssetConst.noBids;
//           titleString = "No Chat Found";
//           des = "You don't have any chat conversation";
//         }
//       case NotFoundType.bid:
//         {
//           imageAsset = AssetConst.noBids;
//           titleString = "No Bids Found";
//           des = "No bid found, start bidding..";
//         }
//       case NotFoundType.internet:
//         {
//           imageAsset = AssetConst.noInternet;
//           titleString = "No Internet";
//           des =
//               "You don't have any Internet access. Please connect your internet and try again";
//         }
//       case NotFoundType.maintenance:
//         {
//           imageAsset = AssetConst.maintenance;
//           titleString = "Maintenance ongoing";
//           des =
//               "Maintenance work is going on in this App. We will come back as soon as possible.";
//         }
//       case NotFoundType.update:
//         {
//           imageAsset = AssetConst.noInternet;
//           titleString = "Update available";
//           des =
//               "You don't have any Internet access. Please connect your internet and try again";
//         }
//       case NotFoundType.earning:
//         {
//           imageAsset = AssetConst.noInternet;
//           titleString = "You have no earning";
//           des =
//               "Start earning by completing Tasks";
//         }
//       case NotFoundType.taskHistory:
//         {
//           imageAsset = AssetConst.note;
//           titleString = "You have no earning";
//           des =
//               "Start earning by completing Tasks";
//         }
//       default:
//         {
//           imageAsset = AssetConst.notFound;
//           titleString = title??"Not Found";
//           des = description??"Previous Task History is Empty";
//         }
//     }

//     titleString = title?? titleString;
//      des = description??des;

//     return Center(
//       child: SingleChildScrollView(
//        // color: Colors.red,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(imageAsset, width: 230, height: 190),
//               kGapXXL,

//               Text(titleString, style: AppTextStyles.headingTS),
//               kGapXL,
//               Text(
//                 textAlign: TextAlign.center,
//                 des,
//                 style: AppTextStyles.infoTSBlack400,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
