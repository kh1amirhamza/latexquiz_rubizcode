import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:latexquiz_rubizcode/core/constants/app_sizes.dart';

class QuizOptionCard extends StatelessWidget {

  final int index;
  final String option;
  final bool isSelected;
  final bool isAnswered;
  final Color backgroundColor;
  final Color borderColor;
  final IconData? icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const QuizOptionCard({
    super.key,
    required this.index,
    required this.option,
    this.isSelected = false,
    this.isAnswered = false,
    required this.backgroundColor,
    required this.borderColor,
    this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 1,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("${index + 1}.", style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface),),
              kGapL,
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    children: _parseLatex(option, context),
                  ),
                ),
              ),
              kGapL,
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _parseLatex(String text, BuildContext context) {
    final theme = Theme.of(context);
    final spans = <InlineSpan>[];
    final regex = RegExp(r'\$\$(.*?)\$\$');
    int lastIndex = 0;
    
    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface,
            ),
          ),
        );
      }
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Math.tex(
            match.group(1)!,
            textStyle: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      );
      lastIndex = match.end;
    }
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: TextStyle(
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
        ),
      );
    }
    return spans;
  }
}
