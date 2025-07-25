import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/section/cubit/section_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/mini_bottom_sheet.dart';
import 'package:toastification/toastification.dart';

class SectionListScreen extends StatefulWidget {
  const SectionListScreen({Key? key}) : super(key: key);

  @override
  State<SectionListScreen> createState() => _SectionListScreenState();
}

class _SectionListScreenState extends State<SectionListScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<SectionCubit>(context).fetchSection();
      BlocProvider.of<SectionCubit>(context).fetchStore();
    });
  }

  String? storeId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SectionCubit, SectionState>(listener: (context, state) {
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
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Space"),
          leading: const CupertinoNavigationBarBackButton(),
          actions: [
            MiniBottomSheet(
              avatarInitials: "S",
              hintText: "",
              label: "Store",
              value: storeId,
              onChanged: (String? value) {
                setState(() {
                  storeId = value;
                });
              },
              items: state.storeList.map((StoreModel store) {
                return DropdownMenuItem<String>(
                  value: store.id.toString(),
                  child: Text(store.name ?? ""),
                );
              }).toList(),
            ),
            horizontalSpaceTiny
          ],
        ),
        body: ListView.builder(
            itemCount: state.sectionList.length,
            itemBuilder: (BuildContext context, int index) {
              SectionModel section = state.sectionList[index];
              if (storeId == null || storeId == section.storeId) {
                return ListViewContainer(
                    child: ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      "/edit_section",
                      arguments: section,
                    );
                  },
                  leading: CircleAvatar(
                      child: Text(
                          section.sectionName.toUpperCase().substring(0, 1))),
                  title: Text(section.sectionName),
                ));
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(CupertinoIcons.add),
            label: Text(
              "Add Space",
              style: kSubtitleRegularTextStyle,
            ),
            onPressed: () => Navigator.of(context).pushNamed("/edit_section")),
      );
    });
  }
}
