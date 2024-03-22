import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';

class TwoRowComponent extends StatelessWidget {
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool? middleSpace;
  final Widget firstComponent;
  final Widget secondComponent;
  const TwoRowComponent(
      {super.key,
      required this.firstComponent,
      required this.secondComponent,
      this.middleSpace = false,
      this.verticalPadding,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding ?? 0,
                  horizontal: horizontalPadding ?? 10),
              child: firstComponent),
        ),
        middleSpace! ? horizontalSpaceSmall : const SizedBox.shrink(),
        Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: horizontalPadding ?? 10),
              child: secondComponent),
        ),
      ],
    );
  }
}
