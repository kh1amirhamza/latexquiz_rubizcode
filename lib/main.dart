import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latexquiz_rubizcode/core/constants/app_text_styles.dart';
import 'package:latexquiz_rubizcode/latex_quiz.dart';
import 'package:oktoast/oktoast.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  await TeXRenderingServer.start();

  runApp(ProviderScope(child: const OKToast(child: LatexQuiz())));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..infoWidget = Icon(FontAwesomeIcons.info, color: Colors.white, size: 40)
    ..successWidget = Icon(
      FontAwesomeIcons.check,
      color: Colors.white,
      size: 40,
    )
    ..errorWidget = Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 40)
    ..textStyle = AppTextStyles.titleTS.copyWith(color: Colors.white)
    ..userInteractions = false
    ..dismissOnTap = false;
}
