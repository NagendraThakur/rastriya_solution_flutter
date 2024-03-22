import 'package:bloc/bloc.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/loyalty_member_model.dart';

part 'loyalty_member_state.dart';

class LoyaltyMemberCubit extends Cubit<LoyaltyMemberState> {
  LoyaltyMemberCubit() : super(LoyaltyMemberState.initial()) {
    fetchLoyalMember();
  }

  Future<void> saveLoyaltyMember(
      {required LoyaltyMemberModel loyaltyMember}) async {
    emit(state.copyWith(isLoading: true));

    try {
      dynamic response;
      final body = {
        "member_name": loyaltyMember.memberName,
        "mobile_number": loyaltyMember.mobileNumber,
        "gender": loyaltyMember.gender,
        "discount_scheme": loyaltyMember.discountScheme,
      };
      if (loyaltyMember.id == null) {
        response = await PostRepository()
            .postRequest(path: GetRepository.loyaltyMember, body: body);
      } else {
        response = await PutRepository().putRequest(
            path: GetRepository.loyaltyMember,
            editId: loyaltyMember.id,
            body: body);
      }
      emit(state.copyWith(isLoading: false));
      if (response["status"] == "success") {
        emit(state.copyWith(
          message: response["message"],
          isLoading: false,
        ));
        fetchLoyalMember();
      } else {
        emit(state.copyWith(message: 'Failed: ${response["message"]}'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed: $e'));
    }
  }

  Future<void> fetchLoyalMember() async {
    emit(state.copyWith(isFetching: true));
    dynamic response = await GetRepository().getRequest(
      path: GetRepository.loyaltyMember,
      additionalHeader: {"company-id": Config.companyInfo!.id},
    );
    emit(state.copyWith(isFetching: false));
    if (response["status"] == "success") {
      List? data = response["data"];
      if (data != null && data.isNotEmpty) {
        List<LoyaltyMemberModel> loyaltyMemberList =
            data.map((ledger) => LoyaltyMemberModel.fromJson(ledger)).toList();
        emit(state.copyWith(loyaltyMemberList: loyaltyMemberList));
      }
    }
  }

  Future<void> searchLoyaltyMember({required String? searchText}) async {
    if (searchText != null && searchText.isNotEmpty) {
      dynamic response = await GetRepository().getRequest(
        path: "${GetRepository.searchLoyaltyMember}/$searchText",
        additionalHeader: {"company-id": Config.companyInfo!.id},
      );
      if (response["status"] == "success") {
        List? data = response["data"];
        if (data != null && data.isNotEmpty) {
          List<LoyaltyMemberModel> loyaltyMemberList = data
              .map((ledger) => LoyaltyMemberModel.fromJson(ledger))
              .toList();
          emit(state.copyWith(loyaltyMemberList: loyaltyMemberList));
        }
      }
    }
  }
}
