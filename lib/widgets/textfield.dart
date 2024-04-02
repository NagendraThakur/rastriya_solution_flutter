import 'package:flutter/material.dart';
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
  final TextStyle? textStyle;
  final bool? enabled;
  final bool? autofocus;
  final TextAlign? textAlign;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? topPadding;
  final InputDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final bool? filled;
  final bool? required;

  const CustomTextField({
    Key? key,
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
    this.textStyle,
    this.textAlign,
    this.onChanged,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.height,
    this.prefixIcon,
    this.topPadding,
    this.decoration,
    this.padding,
    this.filled = true,
    this.required = false,
  }) : super(key: key);

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
            if (labelText != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RichText(
                  text: TextSpan(
                    style: kBodyRegularTextStyle1.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: labelText!,
                      ),
                      if (required!)
                        const TextSpan(
                          text: "*",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            TextFormField(
              autofocus: autofocus ?? false,
              focusNode: focusNode,
              controller: controller,
              enabled: enabled ?? true,
              obscureText: obscureText ?? false,
              keyboardType: textInputType ?? TextInputType.text,
              style: textStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    color: Colors.grey,
                  ),
              validator: validator,
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmitted,
              textAlign: textAlign ?? TextAlign.left,
              decoration: decoration ?? _buildInputDecoration(),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      filled: filled ?? false,
      fillColor: Colors.grey.shade200,
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(5),
      ),
      isDense: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
    );
  }
}
