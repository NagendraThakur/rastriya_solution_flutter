import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class CustomDropDownButton extends StatefulWidget {
  final String label;
  String? value;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String? hintText;
  final EdgeInsetsGeometry? padding;

  CustomDropDownButton({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.padding,
    this.items,
    this.hintText,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _GeneralDropDownButtonState();
}

class _GeneralDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.label, style: kBodyRegularTextStyle1),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                elevation: 2,
                icon: const Icon(CupertinoIcons.chevron_down),
                iconSize: 15,
                value: widget.value,
                borderRadius: BorderRadius.circular(10),
                isDense: true,
                menuMaxHeight: 400,
                onChanged: (String? value) {
                  setState(() {
                    widget.value = value!;
                    widget.onChanged(widget.value!);
                  });
                },
                items: widget.items,
                hint: widget.hintText != null ? Text(widget.hintText!) : null,
                style: const TextStyle(
                    fontFamily: 'Manrope', fontSize: 13, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
