import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/pages/company/cubit/company_cubit.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/drop_down_button.dart';
import 'package:rastriya_solution_flutter/widgets/textfield.dart';
import 'package:toastification/toastification.dart';

class EditCompanyScreen extends StatefulWidget {
  EditCompanyScreen({super.key});

  @override
  State<EditCompanyScreen> createState() => _EditCompanyScreenState();
}

class _EditCompanyScreenState extends State<EditCompanyScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();

  String? industyId;
  String? fisalYearId;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<CompanyCubit>(context).fetchFiscalYear());
  }

  Future<void> createCompany() async {
    DialogUtils.showPleaseWaitProcessingDialog(context);
    final response = await PostRepository()
        .companyPost(path: PostRepository.companySetup, body: {
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
    });

    Future.delayed(Duration.zero, () => Navigator.of(context).pop());
    if (response["status"] == "success") {
      String message = response["message"];
      Future.delayed(
          Duration.zero,
          () => showToastification(
              context: context,
              message: message,
              toastificationType: ToastificationType.success));
      Future.delayed(Duration.zero, () => Navigator.of(context).pop());
    } else if (response["status"] == "error") {
      Map<String, dynamic>? error = response["error"];
      if (error != null) {
        error.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            String message = value.first.toString();
            Future.delayed(
                Duration.zero,
                () => showToastification(
                    context: context,
                    message: message,
                    toastificationType: ToastificationType.error));
          }
        });
      } else {
        String message = response["message"];
        Future.delayed(
            Duration.zero,
            () => showToastification(
                context: context,
                message: message,
                toastificationType: ToastificationType.error));
      }
    } else {
      Future.delayed(
          Duration.zero,
          () => showToastification(
              context: context,
              message: "Server error. Try again later",
              toastificationType: ToastificationType.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Company"),
        leading: const CupertinoNavigationBarBackButton(),
      ),
      body: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Container();
          }
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          DropdownMenuItem(value: "1", child: Text("Retail")),
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
                      items: (BlocProvider.of<CompanyCubit>(context).state
                              as LoadedState)
                          .fiscalYearList
                          ?.map((fiscalYear) {
                        return DropdownMenuItem<String>(
                          value: fiscalYear.id,
                          child: Text(fiscalYear.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomButton(
          horizontalPadding: 20,
          buttonText: "Create",
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
                createCompany();
              }
            }
          }),
    );
  }
}
