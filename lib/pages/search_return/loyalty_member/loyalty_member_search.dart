import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';
import 'package:rastriya_solution_flutter/pages/loyalty_member/cubit/loyalty_member_cubit.dart';
import 'package:rastriya_solution_flutter/pages/search_return/loyalty_member/portion/loyalty_member_bottom_sheet.dart';
import 'package:rastriya_solution_flutter/widgets/data_table.dart';

class LoyaltyMemberSearch extends StatefulWidget {
  const LoyaltyMemberSearch({super.key});

  @override
  State<LoyaltyMemberSearch> createState() => _LoyaltyMemberSearchState();
}

class _LoyaltyMemberSearchState extends State<LoyaltyMemberSearch> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero,
        () => BlocProvider.of<LoyaltyMemberCubit>(context).fetchLoyalMember());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoyaltyMemberCubit, LoyaltyMemberState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: const CupertinoNavigationBarBackButton(),
            title: const Text("Loyalty Member"),
          ),
          body: state.isFetching == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: CustomDataTable(columnNames: const [
                    "Code",
                    "Name",
                    "Phone",
                    "Email",
                  ], createRow: createRow(data: state.loyaltyMemberList)),
                ),
        );
      },
    );
  }

  List<DataRow>? createRow({required List<LoyaltyMemberModel>? data}) {
    if (data!.isEmpty) {
      return null;
    }

    return data.map((LoyaltyMemberModel loyaltyMember) {
      return DataRow(
        selected: false,
        cells: [
          DataCell(Text(loyaltyMember.memberCode ?? "")),
          DataCell(Text(loyaltyMember.memberName)),
          DataCell(Text(loyaltyMember.mobileNumber ?? "")),
          DataCell(Text(loyaltyMember.emailAddress ?? "")),
        ],
        onSelectChanged: (value) {
          loyaltyMemberBottomSheet(
              context: context, loyaltyMember: loyaltyMember);
        },
      );
    }).toList();
  }
}
