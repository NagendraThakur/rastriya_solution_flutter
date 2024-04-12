import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/pages/pos/cubit/pos_cubit.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/check_out_table/check_out_table_portion.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/kot_table/kot_table_portion.dart';
import 'package:rastriya_solution_flutter/pages/pos/portion/table/table_portion.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/mini_bottom_sheet.dart';
import 'package:toastification/toastification.dart';

class RestroMainPage extends StatefulWidget {
  const RestroMainPage({super.key});

  @override
  State<RestroMainPage> createState() => _RestroMainPageState();
}

class _RestroMainPageState extends State<RestroMainPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PosCubit>(context).fetchTables();
    BlocProvider.of<PosCubit>(context).fetchSection();
    BlocProvider.of<PosCubit>(context).fetchCategoryProduct();
    BlocProvider.of<PosCubit>(context).fetchVoidReason();
  }

  String? sectionId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PosCubit, PosState>(
      listener: (context, state) {
        if (state.message != null) {
          showToastification(
              context: context,
              message: state.message!,
              toastificationType: state.message!.contains("Failed")
                  ? ToastificationType.error
                  : ToastificationType.success);
        } else if (state.toastMessage != null) {
          showToast(message: state.toastMessage!);
        } else if (state.billSavedSuccessfully != null) {
          Future.delayed(Duration.zero,
              () => BlocProvider.of<PosCubit>(context).fetchTables());
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              leading: const CupertinoNavigationBarBackButton(),
              actions: [
                MiniBottomSheet(
                  avatarInitials: "S",
                  hintText: "",
                  label: "Section",
                  value: sectionId,
                  onChanged: (String value) {
                    setState(() {
                      sectionId = value;
                    });
                  },
                  items: state.sectionList.map((SectionModel section) {
                    return DropdownMenuItem<String>(
                      value: section.id.toString(),
                      child: Text(section.sectionName),
                    );
                  }).toList(),
                ),
                horizontalSpaceTiny
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: "Tables",
                  ),
                  Tab(
                    text: "Check Out",
                  ),
                  Tab(
                    text: "KOT",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                TablePortion(
                  sectionId: sectionId,
                ),
                CheckOutTablePortion(
                  sectionId: sectionId,
                ),
                KotTablePortion(
                  sectionId: sectionId,
                )
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed("/category_product", arguments: true);
                },
                label: Text(
                  "Take Out",
                  style: kSubtitleRegularTextStyle,
                )),
          ),
        );
      },
    );
  }
}
