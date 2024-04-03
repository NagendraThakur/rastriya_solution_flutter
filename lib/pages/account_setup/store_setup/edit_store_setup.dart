// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/store_setup/cubit/store_setup_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditStoreSetupScreen extends StatefulWidget {
  final StoreModel? store;
  const EditStoreSetupScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  State<EditStoreSetupScreen> createState() => _EditStoreSetupScreenState();
}

class _EditStoreSetupScreenState extends State<EditStoreSetupScreen> {
  TextEditingController storeName = TextEditingController();
  TextEditingController storeAddress = TextEditingController();
  TextEditingController storeContact = TextEditingController();
  TextEditingController storeEmail = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerContact = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.store != null) {
      storeName.text = widget.store?.name ?? "";
      storeAddress.text = widget.store?.address ?? "";
      storeContact.text = widget.store?.phone ?? "";
      storeEmail.text = widget.store?.email ?? "";
      ownerName.text = widget.store?.contactPersonName ?? "";
      ownerContact.text = widget.store?.contactPersonPhone ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(),
        title: Text(widget.store == null ? "Create Store" : "Edit Store"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CustomTextField(
                required: true,
                labelText: "Store Name",
                hintText: "Enter Store Name",
                controller: storeName,
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  required: true,
                  labelText: "Store Address",
                  hintText: "Enter Store Address",
                  controller: storeAddress,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Store Contact",
                  hintText: "Enter Store Contact",
                  controller: storeContact,
                ),
              ),
              CustomTextField(
                required: true,
                labelText: "Store Email",
                hintText: "Enter Store Email",
                controller: storeEmail,
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  required: true,
                  labelText: "Owner Name",
                  hintText: "Enter Owner Name",
                  controller: ownerName,
                ),
                secondComponent: CustomTextField(
                  required: true,
                  labelText: "Owner Contact",
                  hintText: "Enter Owner Contact",
                  controller: ownerContact,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 10,
          buttonText: "Save",
          onPressed: () {
            StoreModel store = StoreModel(
              id: widget.store?.id,
              name: storeName.text,
              address: storeAddress.text,
              phone: storeContact.text,
              email: storeEmail.text,
              contactPersonName: ownerName.text,
              contactPersonPhone: ownerContact.text,
            );
            Future.delayed(
                Duration.zero,
                () => BlocProvider.of<StoreSetupCubit>(context)
                    .saveStore(store: store));
          }),
    );
  }
}
