import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool values;
  final Function(bool)? onChanged;
  final EdgeInsetsGeometry? padding;
  const CustomSwitch(
      {super.key,
      required this.values,
      this.padding,
      this.onChanged,
      required this.label});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(fontSize: 16),
            ),
            CupertinoSwitch(
                activeColor: Colors.blue,
                value: widget.values,
                onChanged: widget.onChanged)
          ],
        ),
      ),
    );
  }
}
