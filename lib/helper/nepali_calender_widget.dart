import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

Future nepaliCalender(
    {required BuildContext context,
    required picker.NepaliDateTime? initalDate}) async {
  picker.NepaliDateTime? _selectedDateTime =
      await picker.showMaterialDatePicker(
    context: context,
    initialDate: initalDate ?? picker.NepaliDateTime.now(),
    firstDate: picker.NepaliDateTime(2000),
    lastDate: picker.NepaliDateTime(2090),
    initialDatePickerMode: DatePickerMode.day,
  );
  log(_selectedDateTime.toString());
  return _selectedDateTime;
}
