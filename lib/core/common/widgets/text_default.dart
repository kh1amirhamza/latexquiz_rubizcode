import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<TextSpan>? textSpans;
  final bool required;
  const TextDefault(
    this.text, {
    super.key,
    this.style,
    this.textSpans,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
    
      text: TextSpan(
        text: text,
        style: style,
        children: [
          if (textSpans != null) ...textSpans!,
          if (required)
            TextSpan(text: "*", style: style?.copyWith(color: Colors.red)),
        ],
      ),
    );
  }
}
