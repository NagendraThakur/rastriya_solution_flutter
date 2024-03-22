import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

showToastification(
    {required BuildContext context,
    required String message,
    required ToastificationType toastificationType}) {
  toastification.show(
    context: context,
    type: toastificationType,
    title: Text(message),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
