import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/unit_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/unit/cubit/unit_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class EditUnitScreen extends StatefulWidget {
  final UnitModel? unit;
  const EditUnitScreen({
    Key? key,
    this.unit,
  }) : super(key: key);

  @override
  State<EditUnitScreen> createState() => _EditUnitScreenState();
}

class _EditUnitScreenState extends State<EditUnitScreen> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Create Brand"),
      ),
      body: CustomTextField(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: "Unit",
        hintText: "Your Unit Name",
        controller: name,
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            UnitModel unit = UnitModel(id: widget.unit?.id, name: name.text);
            BlocProvider.of<UnitCubit>(context).saveUnit(unit: unit);
          }),
    );
  }
}
