// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const BorderContainer({
    Key? key,
    this.color,
    this.borderColor,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor ?? Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
