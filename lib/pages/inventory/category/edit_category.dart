// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/model/print_station_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditCategoryScreen extends StatefulWidget {
  final CategoryModel? category;
  final List<PrintStationModel> printerList;
  const EditCategoryScreen({
    Key? key,
    this.category,
    required this.printerList,
  }) : super(key: key);

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController platinum = TextEditingController(text: "0");
  TextEditingController gold = TextEditingController(text: "0");
  TextEditingController silver = TextEditingController(text: "0");
  TextEditingController seriesPrefix = TextEditingController();
  TextEditingController prefixFormat = TextEditingController();
  bool showInPos = true;
  String? printStationId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.category != null) {
      name.text = widget.category!.name;
      platinum.text = widget.category!.platinumDiscount.toStringAsFixed(2);
      gold.text = widget.category!.goldDiscount.toStringAsFixed(2);
      silver.text = widget.category!.silverDiscount.toStringAsFixed(2);
      seriesPrefix.text = widget.category!.noSeriesPrefix!;
      prefixFormat.text = widget.category!.prefixFormat!;
      showInPos = widget.category?.showPos ?? false;
      printStationId = widget.category?.orderPrintStationId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title:
            Text(widget.category == null ? "Create Category" : "Edit Category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  required: true,
                  labelText: "Name",
                  hintText: "Your Category Name",
                  controller: name,
                ),
                secondComponent: CustomTextField(
                  labelText: "Platinum Discount",
                  hintText: "Platinum Discount Scheme",
                  controller: platinum,
                  textInputType: TextInputType.number,
                ),
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  labelText: "Gold Discount",
                  hintText: "Gold Discount Scheme",
                  controller: gold,
                  textInputType: TextInputType.number,
                ),
                secondComponent: CustomTextField(
                  labelText: "Silver Discount",
                  hintText: "Silver Discount Scheme",
                  controller: silver,
                  textInputType: TextInputType.number,
                ),
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  required: true,
                  labelText: "Series Prefix",
                  hintText: "Your series Prefix",
                  controller: seriesPrefix,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Prefix Format",
                  hintText: "Your Prefix Format",
                  controller: prefixFormat,
                  textInputType: TextInputType.number,
                ),
              ),
              CustomDropDownButton(
                avatarInitials: "P",
                hintText: "Choose Printer",
                label: "Printer",
                value: printStationId,
                padding: const EdgeInsets.only(top: 20),
                onChanged: (String value) {
                  setState(() {
                    printStationId = value;
                  });
                },
                items: widget.printerList.map((printer) {
                  return DropdownMenuItem<String>(
                    value: printer.id,
                    child: Text(printer.printTitle ?? ""),
                  );
                }).toList(),
              ),
              verticalSpaceRegular,
              CustomSwitch(
                values: showInPos,
                label: "Status",
                onChanged: (bool value) {
                  showInPos = value;
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            double platinumDiscount =
                platinum.text.isNotEmpty ? double.parse(platinum.text) : 0.0;
            double goldDiscount =
                gold.text.isNotEmpty ? double.parse(gold.text) : 0.0;
            double silverDiscount =
                silver.text.isNotEmpty ? double.parse(silver.text) : 0.0;

            CategoryModel category = CategoryModel(
                id: widget.category?.id,
                name: name.text,
                noSeriesPrefix: seriesPrefix.text,
                prefixFormat: prefixFormat.text,
                platinumDiscount: platinumDiscount,
                goldDiscount: goldDiscount,
                silverDiscount: silverDiscount,
                bronzeDiscount: 0,
                showPos: showInPos,
                orderPrintStationId: printStationId);
            BlocProvider.of<CategoryCubit>(context)
                .saveCategory(category: category);
          }),
    );
  }
}
