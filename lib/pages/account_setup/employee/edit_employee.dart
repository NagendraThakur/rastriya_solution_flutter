import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/employee_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/cubit/employee_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/switch.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditEmployeeScreen extends StatefulWidget {
  final EmployeeModel? employee;
  final List<StoreModel> storeList;
  final List<TerminalModel> terminalList;
  const EditEmployeeScreen({
    Key? key,
    this.employee,
    required this.storeList,
    required this.terminalList,
  }) : super(key: key);

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController nickName = TextEditingController();
  String? posting;
  String? storeId;
  String? terminalId;
  bool admin = false;
  bool active = true;
  bool posUser = false;
  bool creditSales = false;
  bool rateChange = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.employee != null) {
      email.text = widget.employee?.email ?? "";
      nickName.text = widget.employee?.nickName ?? "";
      posting = widget.employee?.documentPostingLevel;
      storeId = widget.employee?.storeId;
      terminalId = widget.employee?.terminalId;
      admin = widget.employee?.isAdmin ?? false;
      posUser = widget.employee?.posUser ?? false;
      creditSales = widget.employee?.creditSales ?? false;
      rateChange = widget.employee?.rateChange ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? "Create Staff" : "Edit Staff"),
        leading: const CupertinoNavigationBarBackButton(),
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
                  labelText: "Email",
                  hintText: "Your Staff Email",
                  controller: email,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Nick Name",
                  hintText: "Your Staff Nick Name",
                  controller: nickName,
                ),
              ),
              CustomDropDownButton(
                  avatarInitials: "A",
                  hintText: "Choose Authority",
                  label: "POS",
                  value: posting,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    setState(() {
                      posting = value;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                        value: "order", child: Text("Take Order Only")),
                    DropdownMenuItem(
                        value: "posting",
                        child: Text("Take Order & Save Bill")),
                  ]),
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
              CustomDropDownButton(
                avatarInitials: "T",
                hintText: "Choose Terminal",
                label: "Terminal",
                value: terminalId,
                padding: const EdgeInsets.only(top: 20),
                onChanged: (String value) {
                  setState(() {
                    terminalId = value;
                  });
                },
                items: widget.terminalList.map((terminal) {
                  return DropdownMenuItem<String>(
                    value: terminal.id,
                    child: Text(terminal.name ?? ""),
                  );
                }).toList(),
              ),
              verticalSpaceSmall,
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Permission Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                children: [
                  TwoRowComponent(
                    verticalPadding: 10,
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomSwitch(
                      values: admin,
                      label: "Is Admin",
                      onChanged: (value) {
                        admin = value;
                        setState(() {});
                      },
                    ),
                    secondComponent: CustomSwitch(
                      values: active,
                      label: "Status",
                      onChanged: (value) {
                        active = value;
                        setState(() {});
                      },
                    ),
                  ),
                  TwoRowComponent(
                    verticalPadding: 10,
                    horizontalPadding: 0,
                    middleSpace: true,
                    firstComponent: CustomSwitch(
                      values: posUser,
                      label: "Is POS User",
                      onChanged: (value) {
                        posUser = value;
                        setState(() {});
                      },
                    ),
                    secondComponent: CustomSwitch(
                      values: creditSales,
                      label: "Assign Credit",
                      onChanged: (value) {
                        creditSales = value;
                        setState(() {});
                      },
                    ),
                  ),
                  TwoRowComponent(
                      verticalPadding: 10,
                      horizontalPadding: 0,
                      middleSpace: true,
                      firstComponent: CustomSwitch(
                        values: rateChange,
                        label: "Rate Change",
                        onChanged: (value) {
                          rateChange = value;
                          setState(() {});
                        },
                      ),
                      secondComponent: const SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            EmployeeModel employee = EmployeeModel(
                id: widget.employee?.id,
                email: email.text,
                nickName: nickName.text,
                documentPostingLevel: posting,
                storeId: storeId,
                terminalId: terminalId,
                isAdmin: admin,
                isActive: active,
                posUser: posUser,
                creditSales: creditSales,
                rateChange: rateChange,
                exportReport: "0",
                printReport: "0");
            BlocProvider.of<EmployeeCubit>(context)
                .saveEmployee(employee: employee);
          }),
    );
  }
}
