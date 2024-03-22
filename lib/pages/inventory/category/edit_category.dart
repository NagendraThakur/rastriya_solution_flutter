// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/category_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/category/cubit/category_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditCategoryScreen extends StatefulWidget {
  final CategoryModel? category;
  const EditCategoryScreen({
    Key? key,
    this.category,
  }) : super(key: key);

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController platinum = TextEditingController();
  TextEditingController gold = TextEditingController();
  TextEditingController silver = TextEditingController();
  TextEditingController seriesPrefix = TextEditingController();
  TextEditingController prefixFormat = TextEditingController();
  bool showInPos = true;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Create Category"),
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
                  labelText: "Series Prefix",
                  hintText: "Your series Prefix",
                  controller: seriesPrefix,
                ),
                secondComponent: CustomTextField(
                  labelText: "Prefix Format",
                  hintText: "Your Prefix Format",
                  controller: prefixFormat,
                  textInputType: TextInputType.number,
                ),
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
              bronzeDiscount:
                  0, // Assuming bronze discount is not provided in the UI
              showPos: showInPos,
            );
            BlocProvider.of<CategoryCubit>(context)
                .saveCategory(category: category);
          }),
    );
  }
}
