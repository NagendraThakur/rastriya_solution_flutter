import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/fiscal_year_model.dart';

part 'account_setting_state.dart';

class AccountSettingCubit extends Cubit<AccountSettingState> {
  AccountSettingCubit() : super(AccountSettingState.initial()) {
    Future.delayed(Duration.zero, () => fetchFiscalYear());
  }

  Future<void> saveCompany({required dynamic body, required String id}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response = await PutRepository().putRequest(
      editId: id,
      path: PostRepository.companySetup,
      body: body,
    );
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      emit(state.copyWith(message: response["message"]));
      Config.companyInfo = CompanyModel.fromJson(response["company_details"]);
    } else {
      emit(state.copyWith(message: "Failed ${response["message"]}"));
    }
  }

  Future<void> fetchFiscalYear() async {
    emit(state.copyWith(isLoading: true));
    final response = await GetRepository().getRequest(
      path: GetRepository.fiscalYear,
    );
    if (response["status"] == "success") {
      List<dynamic> data = response["fiscal_year_lists"];
      emit(state.copyWith(isLoading: false));
      emit(state.copyWith(
          fiscalYearList:
              data.map((json) => FiscalYearModel.fromJson(json)).toList()));
    }
  }
}
