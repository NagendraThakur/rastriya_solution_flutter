import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class BoxWidget extends StatefulWidget {
  final String label;
  final double? width;

  final String value;
  final EdgeInsetsGeometry? padding;
  const BoxWidget(
      {super.key,
      this.padding,
      this.width,
      required this.value,
      required this.label});

  @override
  State<BoxWidget> createState() => _BoxWidgetState();
}

class _BoxWidgetState extends State<BoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: Container(
        height: 45,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: kBodyRegularTextStyle1,
            ),
            Text(
              widget.value,
              style: kBodyRegularTextStyle1,
            )
          ],
        ),
      ),
    );
  }
}
