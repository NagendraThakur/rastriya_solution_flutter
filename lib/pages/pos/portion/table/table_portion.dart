// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';

import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';

class TablePortion extends StatelessWidget {
  final String? sectionId;
  const TablePortion({
    Key? key,
    this.sectionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosCubit, PosState>(
      builder: (context, state) {
        List<TableModel> filteredTables = state.tableList;

        // Filter tables by sectionId if provided
        if (sectionId != null) {
          filteredTables = state.tableList
              .where((table) => table.sectionId == sectionId)
              .toList();
        }
        return Scaffold(
          body: state.tableList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisExtent: 120,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: filteredTables.length,
                      itemBuilder: (BuildContext context, int index) {
                        TableModel table = filteredTables[index];
                        return InkWell(
                          onTap: () {
                            final cubit = BlocProvider.of<PosCubit>(context);
                            cubit.clearOrder();
                            cubit.assignTable(table: table);
                            Navigator.of(context)
                                .pushNamed("/category_product");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: table.availability == "Available"
                                    ? Colors.grey.shade100
                                    : Colors.green.shade100,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  table.tableName,
                                  style: kSubtitleRegularTextStyle,
                                ),
                                Text(
                                  table.availability,
                                  style: kBodyRegularTextStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        );
      },
    );
  }
}
