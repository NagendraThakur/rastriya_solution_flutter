import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/account_setup/account_setting/cubit/account_setting_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class EditAccountSetting extends StatefulWidget {
  const EditAccountSetting({super.key});

  @override
  State<EditAccountSetting> createState() => _EditAccountSettingState();
}

class _EditAccountSettingState extends State<EditAccountSetting> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();

  // TextEditingController loyaltyMemberPrefix = TextEditingController();
  // TextEditingController printName = TextEditingController();
  // TextEditingController billNarration = TextEditingController();

  String? industyId;
  String? fisalYearId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = Config.companyInfo!.companyName;
    phone.text = Config.companyInfo!.companyPhone;
    address.text = Config.companyInfo!.companyAddress;
    email.text = Config.companyInfo!.companyEmail;
    industyId = Config.companyInfo!.industryId;
    fisalYearId = Config.companyInfo!.fiscalYearId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountSettingCubit, AccountSettingState>(
      listener: (context, state) {
        if (state.message != null) {
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
            title: const Text("Edit Company Setting"),
          ),
          body: state.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CustomTextField(
                            required: true,
                            topPadding: 0,
                            labelText: "Company Name",
                            hintText: "Your Compan Name",
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Company Name cannot be empty";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            required: true,
                            labelText: "Company Contact",
                            hintText: "Your Company Contact",
                            controller: phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Company Contact cannot be empty";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            required: true,
                            labelText: "Company Email",
                            hintText: "Your Company Email",
                            controller: email,
                            validator: (value) {
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!emailRegex.hasMatch(value)) {
                                return "Email must be valid";
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            required: true,
                            labelText: "Company Address",
                            hintText: "Your Company Address",
                            controller: address,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Company Address cannot be empty";
                              }
                              return null;
                            },
                          ),
                          CustomDropDownButton(
                              avatarInitials: "C",
                              hintText: "Choose Category",
                              label: "Company Category",
                              value: industyId,
                              padding: const EdgeInsets.only(top: 20),
                              onChanged: (String value) {
                                industyId = value;
                              },
                              items: const [
                                DropdownMenuItem(
                                    value: "1", child: Text("Retail")),
                                DropdownMenuItem(
                                    value: "2", child: Text("Restaurant")),
                              ]),
                          CustomDropDownButton(
                            avatarInitials: "F",
                            hintText: "Choose Fiscal Year",
                            label: "Fiscal Year",
                            value: fisalYearId,
                            padding: const EdgeInsets.only(top: 20),
                            onChanged: (String value) {
                              setState(() {
                                fisalYearId = value;
                              });
                            },
                            items: state.fiscalYearList.map((fiscalYear) {
                              return DropdownMenuItem<String>(
                                value: fiscalYear.id,
                                child: Text(fiscalYear.name),
                              );
                            }).toList(),
                          ),
                          // ExpansionTile(
                          //   tilePadding: EdgeInsets.zero,
                          //   title: const Text(
                          //     'Additional Details',
                          //     style: TextStyle(
                          //       fontFamily: 'Manrope',
                          //       color: Colors.blue,
                          //       fontSize: 20,
                          //     ),
                          //     textAlign: TextAlign.left,
                          //   ),
                          //   children: [
                          //     CustomTextField(
                          //       labelText: "Loyalty Member Prefix",
                          //       hintText: "Your Loyalty Member Prefix",
                          //       controller: loyaltyMemberPrefix,
                          //     ),
                          //     CustomTextField(
                          //       topPadding: 0,
                          //       labelText: "Print Name",
                          //       hintText: "Your Print Name",
                          //       controller: printName,
                          //     ),
                          //     CustomTextField(
                          //       topPadding: 0,
                          //       labelText: "Bill Narration",
                          //       hintText: "Your Bill Narration",
                          //       controller: billNarration,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: CustomButton(
              horizontalPadding: 10,
              buttonText: "Save",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (industyId == null) {
                    showToastification(
                        context: context,
                        message: "choose Company Category",
                        toastificationType: ToastificationType.info);
                  } else if (fisalYearId == null) {
                    showToastification(
                        context: context,
                        message: "choose Fiscal Year",
                        toastificationType: ToastificationType.info);
                  } else {
                    dynamic body = {
                      "company_name": name.text,
                      "company_address": address.text,
                      "company_phone": phone.text,
                      "company_email": email.text,
                      "company_category": 1,
                      "company_sub_category": 1,
                      "industry_id": industyId,
                      "city": address.text,
                      "fiscal_year_id": fisalYearId,
                      "state_id": 1,
                      "district_id": 1,
                    };
                    BlocProvider.of<AccountSettingCubit>(context)
                        .saveCompany(body: body, id: Config.companyInfo!.id);
                  }
                }
              }),
        );
      },
    );
  }
}
