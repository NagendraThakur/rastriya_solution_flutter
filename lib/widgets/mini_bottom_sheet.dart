import 'package:flutter/material.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';

class MiniBottomSheet extends StatelessWidget {
  final String label;
  String? value;
  final Function(String) onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String hintText;
  final EdgeInsetsGeometry? padding;
  final String avatarInitials;

  MiniBottomSheet({
    required this.label,
    required this.value,
    required this.onChanged,
    this.items,
    required this.hintText,
    this.padding,
    required this.avatarInitials,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value != null ? _getItemChild(value!) : Text(hintText),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  Widget _getItemChild(String value) {
    // Find the DropdownMenuItem corresponding to the selected value
    var selectedItem = items!.firstWhere((item) => item.value == value);
    // Return the child of the selected DropdownMenuItem
    return selectedItem.child!;
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      scrollControlDisabledMaxHeightRatio: 0.9,
      shape: const RoundedRectangleBorder(
        // <-- SEE HERE
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
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
                    const CloseButton()
                  ],
                ),
                verticalSpaceSmall,
                for (var item in items!)
                  ListViewContainer(
                    child: ListTile(
                      onTap: () {
                        value = item.value;
                        onChanged(value!);
                        Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                          backgroundColor: item.value == value
                              ? Colors.blue
                              : Colors.grey.shade400,
                          child: Text(avatarInitials)),
                      title: item.child,
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
