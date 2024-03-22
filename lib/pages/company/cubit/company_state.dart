part of 'company_cubit.dart';

abstract class CompanyState {}

class InitailState extends CompanyState {}

class LoadingState extends CompanyState {
  final bool isLoading;

  LoadingState({required this.isLoading});
}

class LoadedState extends CompanyState {
  final List<CompanyModel>? companyList;
  final List<FiscalYearModel>? fiscalYearList;
  final String? message;

  LoadedState({
    this.fiscalYearList,
    this.companyList,
    this.message,
  });

  LoadedState copyWith({
    List<CompanyModel>? companyList,
    List<FiscalYearModel>? fiscalYearList,
    String? message,
  }) {
    return LoadedState(
      companyList: companyList ?? this.companyList,
      fiscalYearList: fiscalYearList ?? this.fiscalYearList,
      message: message ?? this.message,
    );
  }
}
