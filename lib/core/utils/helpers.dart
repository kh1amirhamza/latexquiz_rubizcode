import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latexquiz_rubizcode/core/constants/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

String formatDate(DateTime date, {String? dateFormat}) {
  // Implement date formatting logic here
  return DateFormat(dateFormat ?? AppConst.dateFormat_Mon_00_2024).format(date);
}

String formatDateRange(DateTimeRange dateTimeRange, {bool showYear = true}) {
  // Implement date formatting logic here
  return "${DateFormat(AppConst.dateFormat_Mon_28_Nov).format(dateTimeRange.start)}  -  ${DateFormat(showYear ? AppConst.dateFormat_Mon_28_Nov_2024 : AppConst.dateFormat_Mon_28_Nov).format(dateTimeRange.end)}";
}

String formatHourMinute(int totalMinutes) {
  int hours = totalMinutes ~/ 60;
  int minutes = totalMinutes % 60;
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')} hrs';
}

String formatTime(DateTime dateTime) {
  return DateFormat(AppConst.timeFormat_hh_mm_a).format(dateTime);
}

Future<DateTime?> pickDate(BuildContext context) async {
  var now = DateTime.now();
  return await showDatePicker(
    context: context,
    initialDate: now,
    firstDate: now.copyWith(year: now.year - 1),
    lastDate: now.copyWith(year: now.year + 1),
  );
}

// Future<Position> _determinePosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//
//   // Check if location services are enabled
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled, request to enable
//     return Future.error('Location services are disabled.');
//   }
//
//   // Check for location permissions
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, return error
//       return Future.error('Location permissions are denied');
//     }
//   }
//
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//
//   // When permissions are granted, get the current position
//   return await Geolocator.getCurrentPosition();
// }
//
// Future<Position?> getCurrentLocation() async {
//   try {
//     Position position = await _determinePosition();
//     return position;
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error: ${e.toString()}");
//     }
//   }
//   return null;
// }
//
//
//
// Future<String> getDeviceUniqueId() async {
//   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   var uniqueID = 'UNKNOWN';
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     // Check Android version (less than 10) or empty/unreliable ANDROID_ID
//     if (androidInfo.version.sdkInt < 29 || androidInfo.id.isEmpty || androidInfo.id == '9774d56d682e549c') {
//       // Fallback to generated persistent UUID for Android 8 or devices with unreliable ID
//       uniqueID = await getPersistentUniqueId();
//     } else {
//       // Use ANDROID_ID for Android 10+ and when the ID is reliable
//       uniqueID = androidInfo.id;
//     }
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     uniqueID = iosInfo.identifierForVendor??uniqueID; // Unique ID for iOS devices
//   }
//   return uniqueID;
// }

// Future<String> getPersistentUniqueId() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? uniqueId = prefs.getString('unique_id');
//
//   if (uniqueId == null) {
//     uniqueId = _generateUuid();
//     await prefs.setString('unique_id', uniqueId);//QP1A.190711.020
//   }
//   return uniqueId;
// }

// String _generateUuid() {
//   var uuid = const Uuid();
//   String uniqueId = uuid.v4(); // Generates a random unique identifier
//   return uniqueId;
// }

// Future<String> getMacAddress2() async {
//   String macAddress = 'Unknown';
//   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//
//   try {
//     if (Platform.isAndroid) {
//       var androidInfo = await deviceInfoPlugin.androidInfo;
//       macAddress = androidInfo.id; // Use androidId as a unique identifier
//       print("CheckMAC_Address: $macAddress");
//       return macAddress;
//     } else if (Platform.isIOS) {
//       var iosInfo = await deviceInfoPlugin.iosInfo;
//       macAddress = iosInfo.identifierForVendor!; // Use identifierForVendor as a unique identifier
//       return macAddress;
//     }
//     return macAddress;
//   } catch (e) {
//     //macAddress = 'Error getting the MAC address.';
//     return macAddress;
//   }
//
//
// }

Future<void> logOut() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(AppConst.loginInfo);
}
