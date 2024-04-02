// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';

import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/cubit/loyalty_member_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';
import 'package:toastification/toastification.dart';

class EditLoyaltyMemberScreen extends StatefulWidget {
  final LoyaltyMemberModel? loyaltyMember;
  EditLoyaltyMemberScreen({
    Key? key,
    this.loyaltyMember,
  }) : super(key: key);

  @override
  State<EditLoyaltyMemberScreen> createState() =>
      _EditLoyaltyMemberScreenState();
}

class _EditLoyaltyMemberScreenState extends State<EditLoyaltyMemberScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  String? gender;

  String? discountScheme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.loyaltyMember != null) {
      name.text = widget.loyaltyMember!.memberName;
      phone.text = widget.loyaltyMember!.mobileNumber!;
      email.text = widget.loyaltyMember!.emailAddress ?? "";
      gender = widget.loyaltyMember?.gender;
      discountScheme = widget.loyaltyMember?.discountScheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text("Create Loyalty Member"),
        elevation: 2,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomTextField(
                labelText: "Name",
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Member Name";
                  }
                  return null;
                },
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomTextField(
                  labelText: "Contact Number",
                  controller: phone,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Member Contact";
                    } else if (value.length != 10) {
                      return "Invalid phone number";
                    }
                    return null;
                  },
                ),
                secondComponent: CustomTextField(
                  labelText: "Email",
                  controller: email,
                  textInputType: TextInputType.number,
                ),
              ),
              TwoRowComponent(
                horizontalPadding: 0,
                middleSpace: true,
                firstComponent: CustomDropDownButton(
                    avatarInitials: "G",
                    hintText: "Select Gender",
                    label: "Gender",
                    value: gender,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: "male", child: Text("male")),
                      DropdownMenuItem(value: "female", child: Text("female")),
                    ]),
                secondComponent: CustomDropDownButton(
                    avatarInitials: "D",
                    hintText: "Select  Scheme",
                    label: "Discount",
                    value: discountScheme,
                    padding: const EdgeInsets.only(top: 20),
                    onChanged: (String value) {
                      setState(() {
                        discountScheme = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                          value: "platinum", child: Text("Platinum Discount")),
                      DropdownMenuItem(
                          value: "gold", child: Text("Gold Discount")),
                      DropdownMenuItem(
                          value: "silver", child: Text("Siver Discount")),
                    ]),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomButton(
          buttonText: "Save",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (gender == null) {
                showToastification(
                    message: "Choose a gender",
                    context: context,
                    toastificationType: ToastificationType.warning);
                return;
              } else if (discountScheme == null) {
                showToastification(
                    message: "Choose a scheme",
                    context: context,
                    toastificationType: ToastificationType.warning);
              }
              LoyaltyMemberModel loyaltyMember = LoyaltyMemberModel(
                id: widget.loyaltyMember?.id,
                memberName: name.text,
                mobileNumber: phone.text,
                emailAddress: email.text,
                gender: gender,
                discountScheme: discountScheme,
              );
              BlocProvider.of<LoyaltyMemberCubit>(context)
                  .saveLoyaltyMember(loyaltyMember: loyaltyMember);
            }
          }),
    );
  }
}
