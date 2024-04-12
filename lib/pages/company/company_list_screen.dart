import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/pages/company/cubit/company_cubit.dart';
import 'package:rastriya_solution_flutter/shared/shared_pre.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/button.dart';
import 'package:rastriya_solution_flutter/widgets/container.dart';
import 'package:rastriya_solution_flutter/widgets/two_row_component.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,
        () => BlocProvider.of<CompanyCubit>(context).fetchCompany());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Companies"),
        leading: const CupertinoNavigationBarBackButton(),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/edit_company").then((value) {
                  Future.delayed(
                      Duration.zero,
                      () => BlocProvider.of<CompanyCubit>(context)
                          .fetchCompany());
                });
              },
              child: const Text("Create"))
        ],
      ),
      body: BlocConsumer<CompanyCubit, CompanyState>(
        listener: (context, state) {
          if (state is LoadingState && state.isLoading == true) {
            return DialogUtils.showProcessingDialog(context);
          } else if (state is LoadingState && state.isLoading == false) {
            return Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, CompanyState state) {
          if (state is LoadedState && state.companyList != null) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500.0,
                mainAxisExtent: 150,
                mainAxisSpacing: 2,
                crossAxisSpacing: 10,
              ),
              itemCount: state.companyList!.length,
              itemBuilder: (BuildContext context, int index) {
                final company = state.companyList![index];
                return CustomContainer(
                  outerHorizontalPadding: 10,
                  innerHorizontalPadding: 10,
                  border: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 10),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: kSubtitleTextStyle,
                                children: [
                                  TextSpan(
                                    text: company.companyName.toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "\n${company.companyAddress.toUpperCase()}",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(company.fiscalYearInfo?.name ?? "")
                          ],
                        ),
                      ),
                      TwoRowComponent(
                          firstComponent: CustomButton(
                              secondaryButton: true,
                              buttonText: "View",
                              onPressed: () {}),
                          secondComponent: CustomButton(
                              buttonText: "Switch",
                              onPressed: () {
                                final companyJson =
                                    json.encode(company.toJson());
                                savePreference(
                                    key: "company", value: companyJson);
                                Config.companyInfo = company;
                                // BlocProvider.of<DashboardCubit>(context)
                                //     .fetchAccountPermission();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/dashboard', (route) => false,
                                    arguments: Config.companyInfo);
                              }))
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     icon: const Icon(CupertinoIcons.add),
      //     label: Text(
      //       "Add Company",
      //       style: kSubtitleRegularTextStyle,
      //     ),
      //     onPressed: () =>
      //         Navigator.of(context).pushNamed("/edit_company").then((value) {
      //           Future.delayed(
      //               Duration.zero,
      //               () =>
      //                   BlocProvider.of<CompanyCubit>(context).fetchCompany());
      //         })),
    );
  }
}
