import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/helper/dialog_utility.dart';
import 'package:rastriya_solution_flutter/helper/toastification.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/cubit/loyalty_member_cubit.dart';
import 'package:rastriya_solution_flutter/shared/text_style.dart';
import 'package:rastriya_solution_flutter/widgets/list_view_container.dart';
import 'package:rastriya_solution_flutter/widgets/shimmer.dart';
import 'package:toastification/toastification.dart';

class LoyaltyMemberList extends StatefulWidget {
  const LoyaltyMemberList({super.key});

  @override
  State<LoyaltyMemberList> createState() => _LoyaltyMemberListState();
}

class _LoyaltyMemberListState extends State<LoyaltyMemberList> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,
        () => BlocProvider.of<LoyaltyMemberCubit>(context).fetchLoyalMember());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoyaltyMemberCubit, LoyaltyMemberState>(
      listener: (context, state) {
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
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Loyalty Member"),
            actions: [
              Text(
                "Length: ${state.loyaltyMemberList?.length}   ",
                style: kSubtitleTextStyle.copyWith(color: Colors.blue),
              )
            ],
          ),
          body: state.isFetching == true
              ? const CustomShimmer()
              : ListView.builder(
                  itemCount: state.loyaltyMemberList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    LoyaltyMemberModel loyaltyMember =
                        state.loyaltyMemberList![index];
                    return ListViewContainer(
                      child: ListTile(
                        onTap: () => Navigator.of(context).pushNamed(
                            "/edit_loyalty_member",
                            arguments: loyaltyMember),
                        leading: CircleAvatar(
                            child: Text(loyaltyMember.memberName
                                .substring(0, 1)
                                .toUpperCase())),
                        title: Text(loyaltyMember.memberName.toUpperCase()),
                        subtitle: Text(
                            "${loyaltyMember.emailAddress?.toUpperCase() ?? ""} ${loyaltyMember.mobileNumber ?? ""}"),
                        trailing: Text(loyaltyMember.memberCode ?? ""),
                      ),
                    );
                  }),
          // : SingleChildScrollView(
          //     child: CustomDataTable(columnNames: const [
          //       "Code",
          //       "Name",
          //       "Phone",
          //       "Email",
          //     ], createRow: createRow(data: state.loyaltyMemberList)),
          //   ),
          floatingActionButton: FloatingActionButton.extended(
              icon: const Icon(CupertinoIcons.add),
              label: Text(
                "Add Loyalty Member",
                style: kSubtitleRegularTextStyle,
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed("/edit_loyalty_member")),
        );
      },
    );
  }

  // List<DataRow>? createRow({required List<LoyaltyMemberModel>? data}) {
  //   if (data!.isEmpty) {
  //     return null;
  //   }

  //   return data.map((LoyaltyMemberModel loyaltyMember) {
  //     return DataRow(
  //       selected: false,
  //       cells: [
  //         DataCell(Text(loyaltyMember.memberCode ?? "-")),
  //         DataCell(Text(loyaltyMember.memberName)),
  //         DataCell(Text(loyaltyMember.mobileNumber ?? "-")),
  //         DataCell(Text(loyaltyMember.emailAddress ?? "-")),
  //       ],
  //       onSelectChanged: (value) {
  //         Navigator.of(context)
  //             .pushNamed("/edit_loyalty_member", arguments: loyaltyMember);
  //       },
  //     );
  //   }).toList();
  // }
}
