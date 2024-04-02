import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetUtils {
  static void optionBottomSheet({
    required BuildContext context,
    required Widget widget,
    required int length,
  }) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.95,
      builder: (BuildContext context) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return widget;
            });
      },
    );
  }
}
