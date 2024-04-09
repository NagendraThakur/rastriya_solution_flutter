import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

Widget summaryWidth({
  required String value,
  required String label,
}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: kSubtitleTextStyle,
      children: [
        TextSpan(
          text: "$value\n",
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
        TextSpan(
          text: label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
