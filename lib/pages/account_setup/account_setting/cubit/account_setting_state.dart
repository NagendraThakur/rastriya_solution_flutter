// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_setting_cubit.dart';

class AccountSettingState {
  final bool? isLoading;
  final bool? isFetching;
  final String? message;
  final List<FiscalYearModel> fiscalYearList;

  AccountSettingState(
      {this.isLoading,
      this.isFetching,
      this.message,
      required this.fiscalYearList});

  factory AccountSettingState.initial() {
    return AccountSettingState(fiscalYearList: []);
  }

  AccountSettingState copyWith({
    bool? isLoading,
    bool? isFetching,
    String? message,
    List<FiscalYearModel>? fiscalYearList,
  }) {
    return AccountSettingState(
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
      fiscalYearList: fiscalYearList ?? this.fiscalYearList,
    );
  }
}
