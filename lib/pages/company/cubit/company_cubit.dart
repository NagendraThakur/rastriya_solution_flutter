import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/fiscal_year_model.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(InitailState());

  Future<void> fetchCompany() async {
    emit(LoadingState(isLoading: true));
    final response = await GetRepository().getRequest(
      path: GetRepository.companySetup,
    );
    if (response["status"] == "success") {
      List<dynamic> companyList = response["company_lists"];
      emit(LoadingState(isLoading: false));
      emit(LoadedState().copyWith(
          companyList:
              companyList.map((json) => CompanyModel.fromJson(json)).toList()));
    }
  }

  Future<void> fetchFiscalYear() async {
    emit(LoadingState(isLoading: true));
    final response = await GetRepository().getRequest(
      path: GetRepository.fiscalYear,
    );
    if (response["status"] == "success") {
      List<dynamic> data = response["fiscal_year_lists"];
      emit(LoadingState(isLoading: false));
      emit(LoadedState().copyWith(
          fiscalYearList:
              data.map((json) => FiscalYearModel.fromJson(json)).toList()));
    }
  }
}
