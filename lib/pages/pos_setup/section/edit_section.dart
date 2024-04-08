import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/pages/pos_setup/section/cubit/section_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class EditSectionScreen extends StatefulWidget {
  final SectionModel? section;
  const EditSectionScreen({
    Key? key,
    this.section,
  }) : super(key: key);

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  final TextEditingController name = TextEditingController();
  String? storeId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.section != null) {
      name.text = widget.section?.sectionName ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const CupertinoNavigationBarBackButton(),
          title: Text(widget.section != null ? "Edit Space" : "Create Space"),
        ),
        body: BlocBuilder<SectionCubit, SectionState>(
          builder: (context, state) {
            return Column(
              children: [
                CustomTextField(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  labelText: "Name",
                  hintText: "Your Section Name",
                  controller: name,
                ),
                CustomDropDownButton(
                  avatarInitials: "S",
                  hintText: "Select Store",
                  label: "store",
                  value: storeId,
                  padding: const EdgeInsets.only(top: 20),
                  onChanged: (String value) {
                    storeId = value;
                  },
                  items: state.storeList.map((StoreModel store) {
                    return DropdownMenuItem<String>(
                      value: store.id.toString(),
                      child: Text(store.name ?? ""),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: CustomButton(
            buttonText: "Save",
            onPressed: () {
              SectionModel section = SectionModel(
                  id: widget.section?.id,
                  sectionName: name.text,
                  storeId: Config.storeInfo!.id!);

              BlocProvider.of<SectionCubit>(context)
                  .saveSection(section: section);
            }));
  }
}
