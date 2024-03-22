// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/pages/ledger_accounts/cubit/ledger_cubit.dart';
import 'package:rastriya_solution_flutter/shared/spacing.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class EditVendor extends StatefulWidget {
  final LedgerModel? ledger;
  const EditVendor({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pan = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController creditLimit = TextEditingController();
  TextEditingController shippingAddress = TextEditingController();
  TextEditingController shippingPhone = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.ledger != null) {
      name.text = widget.ledger!.name;
      phone.text = widget.ledger?.billingPhone1 ?? "";
      address.text = widget.ledger?.billingAddress1 ?? "";
      pan.text = widget.ledger?.panNo ?? "";
      email.text = widget.ledger?.billingEmail ?? "";
      creditLimit.text = widget.ledger?.creditLimitAmount ?? "";
      shippingAddress.text = widget.ledger?.shippingAddress1 ?? "";
      shippingPhone.text = widget.ledger?.shippingPhone1 ?? "";
      description.text = widget.ledger?.contactDescription ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Vendor"),
        leading: const CupertinoNavigationBarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                labelText: "Vendor Name",
                hintText: "Enter Vendor Name",
                controller: name,
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  controller: phone,
                ),
                secondComponent: CustomTextField(
                  labelText: "Address",
                  hintText: "Enter Address",
                  controller: address,
                ),
              ),
              verticalSpaceSmall,
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: const Text(
                  'Additional Details',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.left,
                ),
                children: [
                  CustomTextField(
                    labelText: "PAN",
                    hintText: "Enter PAN",
                    controller: pan,
                  ),
                  CustomTextField(
                    labelText: "Email",
                    hintText: "Enter Email",
                    controller: email,
                  ),
                  CustomTextField(
                    labelText: "Credit Limit",
                    hintText: "Enter Credit Limit",
                    controller: creditLimit,
                  ),
                  CustomTextField(
                    labelText: "Shipping Address",
                    hintText: "Enter Shipping Address",
                    controller: shippingAddress,
                  ),
                  CustomTextField(
                    labelText: "Shipping Contact",
                    hintText: "Enter Shipping Contact",
                    controller: shippingPhone,
                  ),
                  CustomTextField(
                    labelText: "Description",
                    hintText: "Enter Description",
                    controller: description,
                  ),
                  verticalSpaceSmall,
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
            LedgerModel ledger = LedgerModel(
              id: widget.ledger?.id,
              ledgerType: "v",
              cash: "1",
              bank: "1",
              name: name.text,
              billingPhone1: phone.text,
              billingAddress1: address.text,
              panNo: pan.text,
              billingEmail: email.text,
              creditLimitAmount: creditLimit.text,
              shippingAddress1: shippingAddress.text,
              shippingPhone1: shippingAddress.text,
              contactDescription: description.text,
            );
            BlocProvider.of<LedgerCubit>(context).saveLedger(ledger: ledger);
          }),
    );
  }
}
