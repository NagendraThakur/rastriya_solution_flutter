// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:rastriya_solution_flutter/model/ledger_model.dart';

class EditGeneralLedger extends StatefulWidget {
  final LedgerModel? ledger;
  const EditGeneralLedger({
    Key? key,
    this.ledger,
  }) : super(key: key);

  @override
  State<EditGeneralLedger> createState() => _EditGeneralLedgerState();
}

class _EditGeneralLedgerState extends State<EditGeneralLedger> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
