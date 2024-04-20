import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';

void checkBoxFilterBottomSheet({
  required BuildContext context,
  required String label,
  required List<String> checkBoxItems,
  required Function(List<String>) onSearchPressed,
}) {
  List<String> selectedItems = [];

  showModalBottomSheet(
    context: context,
    scrollControlDisabledMaxHeightRatio: 0.9,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpaceTiny,
                  Container(
                    height: 5,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: kHeading3TextStyle,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  // List of checkbox items
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: checkBoxItems.map((item) {
                      return CheckboxListTile(
                        title: Text(item),
                        value: selectedItems.contains(item),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              selectedItems.add(item);
                            } else {
                              selectedItems.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  CustomButton(
                      buttonText: "Search",
                      onPressed: () {
                        onSearchPressed(selectedItems);
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
