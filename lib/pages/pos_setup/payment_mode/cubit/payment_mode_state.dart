part of 'payment_mode_cubit.dart';

class PaymentModeState {
  final List<PaymentModeModel> paymentModeList;
  final List<LedgerModel> ledgerList;
  final List<PaymentModeImageModel> paymentModeImageList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  PaymentModeState({
    required this.paymentModeList,
    required this.ledgerList,
    required this.paymentModeImageList,
    this.isLoading,
    this.isFetching,
    this.message,
  });

  factory PaymentModeState.initial() {
    return PaymentModeState(
      paymentModeList: [],
      ledgerList: [],
      paymentModeImageList: [],
    );
  }

  PaymentModeState copyWith({
    List<PaymentModeModel>? paymentModeList,
    List<LedgerModel>? ledgerList,
    List<PaymentModeImageModel>? paymentModeImageList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return PaymentModeState(
      paymentModeList: paymentModeList ?? this.paymentModeList,
      ledgerList: ledgerList ?? this.ledgerList,
      paymentModeImageList: paymentModeImageList ?? this.paymentModeImageList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
