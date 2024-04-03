import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/brand_model.dart';
import 'package:rastriya_solution_flutter/pages/inventory/brand/cubit/brand_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';

class EditBrandScreen extends StatefulWidget {
  final BrandModel? brand;
  const EditBrandScreen({
    Key? key,
    this.brand,
  }) : super(key: key);

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  TextEditingController brandName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: const Text("Create Brand"),
      ),
      body: CustomTextField(
        required: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: "Brand",
        hintText: "Your Brand Name",
        controller: brandName,
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            BrandModel brand = BrandModel(
                id: widget.brand?.id, name: brandName.text, logo: "gg");
            BlocProvider.of<BrandCubit>(context).saveBrand(brand: brand);
          }),
    );
  }
}
