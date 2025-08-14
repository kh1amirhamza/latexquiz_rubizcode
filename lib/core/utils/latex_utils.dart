import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

Widget buildLatex(String content, {double fontSize = 18}) {
  return TeX2SVG(teXInputType: TeXInputType.teX, math: content);

  return TeXView(
    child: TeXViewDocument(
      content,
      style: TeXViewStyle(
        textAlign: TeXViewTextAlign.center,
        contentColor: Colors.black,
        fontStyle: TeXViewFontStyle(fontSize: fontSize.toInt()),
      ),
    ),
    style: const TeXViewStyle(
      backgroundColor: Colors.transparent,
      padding: TeXViewPadding.all(0),
    ),
  );
}
