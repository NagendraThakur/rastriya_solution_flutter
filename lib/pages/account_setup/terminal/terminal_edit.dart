// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/terminal/cubit/terminal_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class TerminalEditScreen extends StatefulWidget {
  final List<StoreModel> storeList;
  final TerminalModel? terminal;
  const TerminalEditScreen({
    Key? key,
    required this.storeList,
    this.terminal,
  }) : super(key: key);

  @override
  State<TerminalEditScreen> createState() => _TerminalEditScreenState();
}

class _TerminalEditScreenState extends State<TerminalEditScreen> {
  TextEditingController terminalName = TextEditingController();
  String? storeId;
  TextEditingController printerName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.terminal != null) {
      terminalName.text = widget.terminal!.terminalName ?? "";
      printerName.text = widget.terminal!.billPrinterName ?? "";
      storeId = widget.terminal!.storeId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Create Terminal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TwoRowComponent(
              horizontalPadding: 0,
              middleSpace: true,
              firstComponent: CustomTextField(
                labelText: "Terminal Name",
                hintText: "Enter Terminal Name",
                controller: terminalName,
                required: true,
              ),
              secondComponent: CustomTextField(
                labelText: "Printer Name",
                hintText: "Enter Printer Name",
                controller: printerName,
                required: true,
              ),
            ),
            CustomDropDownButton(
              avatarInitials: "S",
              hintText: "Choose Store",
              label: "Store",
              value: storeId,
              padding: const EdgeInsets.only(top: 20),
              onChanged: (String value) {
                setState(() {
                  storeId = value;
                });
              },
              items: widget.storeList.map((store) {
                return DropdownMenuItem<String>(
                  value: store.id,
                  child: Text(store.name ?? ""),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            TerminalModel terminal = TerminalModel(
                id: widget.terminal?.id,
                terminalName: terminalName.text,
                storeId: storeId,
                billPrinterName: printerName.text);
            Future.delayed(
                Duration.zero,
                () => BlocProvider.of<TerminalCubit>(context)
                    .saveTerminal(terminal: terminal));
          }),
    );
  }
}
