import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';

class TerminalResponse {
  final String? status;
  final String? message;
  final TerminalModel? terminal;
  final List<StoreModel>? storeLists;

  TerminalResponse({
    this.status,
    this.message,
    this.terminal,
    this.storeLists,
  });

  factory TerminalResponse.fromJson(Map<String, dynamic> json) {
    return TerminalResponse(
      status: json['status'],
      message: json['message'],
      terminal: json['terminal'] != null
          ? TerminalModel.fromJson(json['terminal'])
          : null,
      storeLists: json['store_lists'] != null
          ? List<StoreModel>.from(
              json['store_lists'].map((store) => StoreModel.fromJson(store)))
          : null,
    );
  }
}
