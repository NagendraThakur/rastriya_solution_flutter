// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_setting_cubit.dart';

class AccountSettingState {
  final bool? isLoading;
  final String? message;
  final List<FiscalYearModel> fiscalYearList;

  AccountSettingState(
      {this.isLoading, this.message, required this.fiscalYearList});

  factory AccountSettingState.initial() {
    return AccountSettingState(fiscalYearList: []);
  }

  AccountSettingState copyWith({
    bool? isLoading,
    String? message,
    List<FiscalYearModel>? fiscalYearList,
  }) {
    return AccountSettingState(
      isLoading: isLoading,
      message: message,
      fiscalYearList: fiscalYearList ?? this.fiscalYearList,
    );
  }
}
