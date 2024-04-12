import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/employee_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/employee/cubit/employee_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,
        () => BlocProvider.of<EmployeeCubit>(context).fetchEmployee());
    Future.delayed(Duration.zero,
        () => BlocProvider.of<EmployeeCubit>(context).fetchTerminal());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          Future.delayed(
              Duration.zero, () => DialogUtils.showProcessingDialog(context));
        } else if (state.isLoading == false) {
          Navigator.of(context).pop();
        } else if (state.message != null) {
          if (state.message!.contains("Admin Employee Cannot Be Deleted")) {
            showToastification(
                context: context,
                message: "Insufficient Authority",
                toastificationType: state.message!.contains("Failed")
                    ? ToastificationType.warning
                    : ToastificationType.success);
            return;
          }
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              title: const Text("Staff"),
            ),
            body: state.isFetching == true
                ? const CustomShimmer()
                : ListView.builder(
                    itemCount: state.employeeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      EmployeeModel employee = state.employeeList[index];
                      return ListViewContainer(
                          child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/edit_employee",
                            arguments: {
                              "employee": employee,
                              "terminalList": state.terminalList,
                              "storeList": state.storeList
                            },
                          );
                        },
                        leading: CircleAvatar(
                          child: Text(
                              employee.nickName!.substring(0, 2).toUpperCase()),
                        ),
                        title: Text(employee.nickName!),
                        subtitle: Text(employee.email ?? ""),
                        trailing: Text(
                          "${employee.storeName ?? ""}\n${employee.terminalName ?? ""}",
                          textAlign: TextAlign.end,
                        ),
                      ));
                    }),
            // : SingleChildScrollView(
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: CustomDataTable(columnNames: const [
            //         "Email",
            //         "Nick Name",
            //         "Assigned Store",
            //         "Assigned Terminal",
            //       ], createRow: createRow(state.employeeList, state)),
            //     ),
            //   ),
            floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(CupertinoIcons.add),
                label: Text(
                  "Add Staff",
                  style: kSubtitleRegularTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "/edit_employee",
                    arguments: {
                      "terminalList": state.terminalList,
                      "storeList": state.storeList
                    },
                  );
                }));
      },
    );
  }

  List<DataRow> createRow(List<EmployeeModel> data, EmployeeState state) {
    return data.map((EmployeeModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(
            item.email ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.nickName ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.storeName ?? "-",
            style: kBodyRegularTextStyle,
          )),
          DataCell(Text(
            item.terminalName ?? "-",
            style: kBodyRegularTextStyle,
          )),
        ],
        onSelectChanged: (value) async {
          Navigator.of(context).pushNamed(
            "/edit_employee",
            arguments: {
              "employee": value,
              "terminalList": state.terminalList,
              "storeList": state.storeList
            },
          );
        },
      );
    }).toList();
  }
}
