import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/table_model.dart';

part 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  TableCubit() : super(TableState.initial());

  Future<void> saveTable({required TableModel table}) async {
    emit(state.copyWith(isLoading: true));
    dynamic response;
    if (table.id == null) {
      response = await PostRepository()
          .postRequest(path: GetRepository.table, body: table.toJson());
    } else {
      response = await PutRepository().putRequest(
          path: GetRepository.table,
          editId: table.id!.toString(),
          body: table.toJson());
    }
    emit(state.copyWith(isLoading: false));
    if (response["status"] == "success") {
      emit(state.copyWith(message: response["message"], isLoading: false));
      fetchTables();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  Future<void> fetchTables() async {
    emit(state.copyWith(isFetching: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.table,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> tableList = response["data"];
        emit(state.copyWith(
          tableList:
              tableList.map((json) => TableModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
      emit(state.copyWith(isFetching: false));
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

  Future<void> fetchSection() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.section,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> sectionList = response["data"];
        emit(state.copyWith(
          sectionList:
              sectionList.map((json) => SectionModel.fromJson(json)).toList(),
        ));
        log(state.sectionList.length.toString());
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }
}
