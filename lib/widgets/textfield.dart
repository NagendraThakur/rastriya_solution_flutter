import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class CustomTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final bool? obscureText;
  final IconData? icon;
  final String? hintText;
  final String? labelText;
  final TextInputType? textInputType;
  final TextStyle? style;
  final bool? enabled;
  final bool? autofocus;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? topPadding;
  final InputDecoration? inputDecoration;
  final InputBorder? inputBorder;
  final EdgeInsetsGeometry? padding;

  const CustomTextField({
    super.key,
    this.focusNode,
    this.icon,
    this.hintText,
    this.labelText,
    this.textInputType,
    this.obscureText,
    this.enabled,
    this.autofocus,
    this.width,
    this.controller,
    this.validator,
    this.style,
    this.textAlign,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.height,
    this.prefixIcon,
    this.topPadding,
    this.inputDecoration,
    this.inputBorder,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: topPadding ?? 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText != null
                ? Text(labelText!, style: kBodyRegularTextStyle1)
                : const SizedBox.shrink(),
            TextFormField(
              autofocus: autofocus ?? false,
              focusNode: focusNode,
              controller: controller,
              enabled: enabled ?? true,
              obscureText: obscureText ?? false,
              keyboardType: textInputType ?? TextInputType.text,
              style: style ??
                  const TextStyle(
                      fontFamily: 'Manrope', fontSize: 13, color: Colors.grey),
              validator: validator,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              textAlign: textAlign ?? TextAlign.left,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  border: inputBorder ?? const OutlineInputBorder(),
                  isDense: true,
                  hintText: hintText,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon),
            ),
          ],
        ),
      ),
    );
  }
}
