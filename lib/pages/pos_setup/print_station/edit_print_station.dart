// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/print_station_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/print_station/cubit/print_station_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditPrintStation extends StatefulWidget {
  final PrintStationModel? printstation;
  const EditPrintStation({
    Key? key,
    this.printstation,
  }) : super(key: key);

  @override
  State<EditPrintStation> createState() => _EditPrintStationState();
}

class _EditPrintStationState extends State<EditPrintStation> {
  final TextEditingController printerName = TextEditingController();
  final TextEditingController printTitle = TextEditingController();
  bool doubleCopy = true;
  String orderPrinterSize = "2";
  String endGapSized = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.printstation != null) {
      printerName.text = widget.printstation?.printerName ?? "";
      printTitle.text = widget.printstation?.printTitle ?? "";
      doubleCopy = widget.printstation?.doubleCopy == "0" ? false : true;
      orderPrinterSize = widget.printstation?.orderPrintSizeInInch ?? "2";
      endGapSized = widget.printstation?.endGapSizeInInch ?? "1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(
            widget.printstation == null ? "Create Printer" : "Edit Printer"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TwoRowComponent(
                middleSpace: true,
                horizontalPadding: 0,
                firstComponent: CustomTextField(
                  required: true,
                  labelText: "Name",
                  controller: printerName,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Title",
                  controller: printTitle,
                )),
            CustomSwitch(
              values: doubleCopy,
              label: "Status",
              padding: const EdgeInsets.only(top: 20),
              onChanged: (value) {
                doubleCopy = value;
                setState(() {});
              },
            ),
            // TwoRowComponent(
            //   middleSpace: true,
            //   horizontalPadding: 0,
            //   firstComponent: CustomDropDownButton(
            //       avatarInitials: "S",
            //       hintText: "Select size",
            //       label: "Print Size",
            //       value: orderPrinterSize,
            //       padding: const EdgeInsets.only(top: 20),
            //       onChanged: (String value) {
            //         orderPrinterSize = value;
            //       },
            //       items: const [
            //         DropdownMenuItem(value: "2", child: Text("2 inch")),
            //         DropdownMenuItem(value: "3", child: Text("3 inch")),
            //       ]),
            //   secondComponent: CustomDropDownButton(
            //       avatarInitials: "E",
            //       hintText: "Select End Gap",
            //       label: "End Gap Size",
            //       value: endGapSized,
            //       padding: const EdgeInsets.only(top: 20),
            //       onChanged: (String value) {
            //         endGapSized = value;
            //       },
            //       items: const [
            //         DropdownMenuItem(value: "1", child: Text("1 inch")),
            //         DropdownMenuItem(value: "2", child: Text("2 inch")),
            //         DropdownMenuItem(value: "3", child: Text("3 inch")),
            //       ]),
            // )
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            PrintStationModel printStation = PrintStationModel(
              id: widget.printstation?.id,
              printerName: printerName.text,
              printTitle: printTitle.text,
              doubleCopy: doubleCopy ? "1" : "0",
              orderPrintSizeInInch: "3",
              endGapSizeInInch: "1",
            );
            BlocProvider.of<PrintStationCubit>(context)
                .savePrintStation(printStation: printStation);
          }),
    );
  }
}
