import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/unit/cubit/unit_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class UnitListScreen extends StatefulWidget {
  const UnitListScreen({super.key});

  @override
  State<UnitListScreen> createState() => _UnitListScreenState();
}

class _UnitListScreenState extends State<UnitListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration.zero, () => BlocProvider.of<UnitCubit>(context).fetchUnits());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        if (state.isLoading == true) {
          Future.delayed(
              Duration.zero, () => DialogUtils.showProcessingDialog(context));
        } else if (state.isLoading == false) {
          Navigator.of(context).pop();
        } else if (state.message != null) {
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
            title: const Text("Units"),
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : ListView.builder(
                  itemCount: state.unitList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    UnitModel unit = state.unitList![index];
                    return ListViewContainer(
                        child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/edit_unit", arguments: unit);
                      },
                      leading: CircleAvatar(
                          child: Text(unit.name.substring(0, 1).toUpperCase())),
                      title: Text(unit.name.toUpperCase()),
                    ));
                  }),
          // : SingleChildScrollView(
          //     child: CustomDataTable(
          //         columnNames: const ["Name"],
          //         createRow: createRow(data: state.unitList)),
          //   ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Unit",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () => Navigator.of(context).pushNamed("/edit_unit")),
        );
      },
    );
  }

  List<DataRow>? createRow({required List<UnitModel>? data}) {
    if (data!.isEmpty) {
      return null;
    }

    return data.map((UnitModel item) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(item.name)),
        ],
        onSelectChanged: (value) {
          Navigator.of(context).pushNamed("/edit_unit", arguments: item);
        },
      );
    }).toList();
  }
}
