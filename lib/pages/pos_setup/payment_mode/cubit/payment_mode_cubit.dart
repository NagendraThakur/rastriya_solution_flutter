import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/get_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/post_repository.dart';
import 'package:rastriya_solution_flutter/data/repository/put_repository.dart';
import 'package:rastriya_solution_flutter/model/ledger_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_image_model.dart';
import 'package:rastriya_solution_flutter/model/payment_mode_model.dart';

part 'payment_mode_state.dart';

class PaymentModeCubit extends Cubit<PaymentModeState> {
  PaymentModeCubit() : super(PaymentModeState.initial());

  Future<void> savePaymentMode({required PaymentModeModel paymentMode}) async {
    emit(state.copyWith(isLoading: true));
    dynamic body = {
      'name': paymentMode.name,
      'status': paymentMode.status ? 1 : 0,
      'ledger_code': paymentMode.ledgerCode,
      'type': paymentMode.type,
      'store_id': paymentMode.storeId,
      'image': paymentMode.image
    };
    dynamic response;
    if (paymentMode.id == null) {
      response = await PostRepository()
          .postRequest(path: PostRepository.paymentMode, body: body);
    } else {
      response = await PutRepository().putRequest(
          path: PostRepository.paymentMode,
          editId: paymentMode.id!,
          body: body);
    }
    emit(state.copyWith(isLoading: false));

    if (response["status"] == "success") {
      emit(state.copyWith(
        message: response["message"],
      ));
      emit(state.copyWith(isLoading: false));
      fetchPaymentMode();
    } else {
      emit(state.copyWith(message: 'Failed: ${response["message"]}'));
    }
  }

  Future<void> fetchPaymentModeImages() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.paymentModeImage,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> data = response["data"];
        emit(state.copyWith(
          paymentModeImageList:
              data.map((json) => PaymentModeImageModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(
          message: 'Failed to fetch payment mode image data',
        ));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

  // fetch ledger for updates payment mode screen to display ladgers options
  Future<void> fetchLedgers() async {
    try {
      final response = await GetRepository().getRequest(
          path: GetRepository.ledger,
          queryParameters: {"type": "G", "cash_or_bank": 1},
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> ledgerData = response["data"];
        emit(state.copyWith(
          ledgerList:
              ledgerData.map((json) => LedgerModel.fromJson(json)).toList(),
        ));
      } else {
        emit(state.copyWith(
          message: 'Failed to fetch ledger data',
        ));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }

  // fetch payment modes for the view payment modes
  Future<void> fetchPaymentMode() async {
    try {
      emit(state.copyWith(isFetching: true));
      final response = await GetRepository().getRequest(
          path: GetRepository.paymentMode,
          additionalHeader: {"company-id": Config.companyInfo!.id});

      if (response["status"] == "success") {
        List<dynamic> paymentModeData = response["data"];
        emit(state.copyWith(
          paymentModeList: paymentModeData
              .map((json) => PaymentModeModel.fromJson(json))
              .toList(),
        ));
      } else {
        emit(state.copyWith(message: 'Failed to fetch data'));
      }
      emit(state.copyWith(isFetching: false));
    } catch (e) {
      emit(state.copyWith(message: 'Error: $e'));
    }
  }
}
