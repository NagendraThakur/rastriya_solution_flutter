import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/section_model.dart';
import 'package:rastriya_solution_flutter/model/store_model.dart';

part 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  SectionCubit() : super(SectionState.initial());
  Future<void> fetchStore() async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.store,
          additionalHeader: {"company-id": Config.companyInfo!.id});
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        List<dynamic> data = response["store_lists"];
        emit(state.copyWith(
          storeList: data.map((json) => StoreModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> saveSection({required SectionModel section}) async {
    dynamic response;
    if (section.id == null) {
      response = await PostRepository()
          .postRequest(path: GetRepository.section, body: section.toJson());
    } else {
      response = await PutRepository().putRequest(
          path: GetRepository.section,
          editId: section.id!.toString(),
          body: section.toJson());
    }

    if (response["status"] == "success") {
      emit(state.copyWith(message: response["message"], isLoading: false));
      fetchSection();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  Future<void> fetchSection() async {
    emit(state.copyWith(isLoading: true, message: ''));

    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.section,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> sectionList = response["data"];
        emit(state.copyWith(
          sectionList:
              sectionList.map((json) => SectionModel.fromJson(json)).toList(),
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e', isLoading: false));
    }
  }
}
