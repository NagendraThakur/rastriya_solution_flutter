import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/employee_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';
import 'package:rastriya_solution_flutter/model/terminal_model.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState.initial());
  Future<void> fetchEmployee() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.employee,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["employee_lists"];
        emit(state.copyWith(
          employeeList:
              data.map((json) => EmployeeModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> saveEmployee({required EmployeeModel employee}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;
      final body = {
        "email": employee.email,
        "permission": {
          "is_admin": employee.isAdmin == true ? 1 : 0,
          "is_active": employee.isAdmin == true ? 1 : 0,
          "document_posting_level": employee.documentPostingLevel,
          "nick_name": employee.nickName,
          "export_report": 0,
          "print_report": 0,
          "pos_user": employee.isAdmin == true ? 1 : 0,
          "credit_sales": employee.isAdmin == true ? 1 : 0,
          "rate_change": employee.isAdmin == true ? 1 : 0,
          "store_id": employee.storeId,
          "terminal_id": employee.terminalId
        }
      };
      if (employee.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.employee, body: body);
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.employee, editId: employee.id, body: body);
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchEmployee();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchTerminal() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.posTerminal,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isFetching: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["terminal_lists"];
        List<dynamic> storeList = response["store_lists"];
        emit(state.copyWith(
          terminalList:
              data.map((json) => TerminalModel.fromJson(json)).toList(),
          storeList:
              storeList.map((json) => StoreModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }
}
