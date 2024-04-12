import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '') {
      return newValue;
    } else {
      int newNumber = int.tryParse(newValue.text) ?? min; // Parse or set to min
      return (newNumber < min)
          ? TextEditingValue().copyWith(text: min.toString())
          : (newNumber > max)
              ? oldValue
              : newValue;
    }
  }
}
