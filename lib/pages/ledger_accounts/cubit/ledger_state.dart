part of 'ledger_cubit.dart';

class LedgerState {
  final List<LedgerModel>? ledgerList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  LedgerState(
      {required this.ledgerList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory LedgerState.initial() {
    return LedgerState(ledgerList: []);
  }

  LedgerState copyWith({
    List<LedgerModel>? ledgerList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return LedgerState(
      ledgerList: ledgerList ?? this.ledgerList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
