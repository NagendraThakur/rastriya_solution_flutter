import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/table_setup/cubit/table_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class EditTableSetup extends StatefulWidget {
  final TableModel? table;
  const EditTableSetup({
    Key? key,
    this.table,
  }) : super(key: key);

  @override
  State<EditTableSetup> createState() => _EditTableSetupState();
}

class _EditTableSetupState extends State<EditTableSetup> {
  final TextEditingController name = TextEditingController();
  bool status = true;
  String capacity = "1";
  String availability = "Available";
  String? sectionId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TableCubit>(context).fetchSection();
    if (widget.table != null) {
      name.text = widget.table?.tableName ?? "";
      status = widget.table?.status == 0 ? false : true;
      availability = widget.table?.availability ?? "Available";
      capacity = widget.table?.guestCapacity != null
          ? widget.table!.guestCapacity.toString()
          : "1";
      sectionId = widget.table?.sectionId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(widget.table == null ? "Create Table" : "Edit Table"),
      ),
      body: BlocBuilder<TableCubit, TableState>(
        builder: (context, state) {
          List<SectionModel> sectionList = state.sectionList;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomTextField(
                  required: true,
                  labelText: "Name",
                  controller: name,
                ),
                CustomSwitch(
                  values: status,
                  label: "Status",
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (value) {
                    status = value;
                    setState(() {});
                  },
                ),
                CustomDropDownButton(
                    avatarInitials: "A",
                    hintText: "Select Availability",
                    label: "Availability",
                    value: availability,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      availability = value;
                    },
                    items: const [
                      DropdownMenuItem(
                          value: "Available", child: Text("Available")),
                      DropdownMenuItem(
                          value: "Occupied", child: Text("Occupied")),
                      DropdownMenuItem(
                          value: "Reserved", child: Text("Reserved")),
                    ]),
                CustomDropDownButton(
                    avatarInitials: "C",
                    hintText: "Select Capacity",
                    label: "Capacity",
                    value: capacity,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      capacity = value;
                    },
                    items: List.generate(20, (index) {
                      return DropdownMenuItem(
                        value: (index + 1).toString(),
                        child: Text((index + 1).toString()),
                      );
                    })),
                CustomDropDownButton(
                  avatarInitials: "S",
                  hintText: "Select Section",
                  label: "Section",
                  value: sectionId,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    sectionId = value;
                  },
                  items: sectionList.map((SectionModel section) {
                    return DropdownMenuItem<String>(
                      value: section.id.toString(),
                      child: Text(section.sectionName),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            if (sectionId == null) {
              showToastification(
                  message: "section a section",
                  context: context,
                  toastificationType: ToastificationType.warning);
              return;
            }
            TableModel table = TableModel(
                id: widget.table?.id,
                tableName: name.text,
                status: status ? 1 : 0,
                availability: availability,
                guestCapacity: int.parse(capacity),
                sectionId: sectionId!);
            BlocProvider.of<TableCubit>(context).saveTable(table: table);
          }),
    );
  }
}
