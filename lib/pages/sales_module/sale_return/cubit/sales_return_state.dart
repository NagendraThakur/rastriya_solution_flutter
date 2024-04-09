part of 'sales_return_cubit.dart';

class SalesReturnState {
  final bool? isLoading;
  final List<BillModel>? salesBillList;
  final List<BillModel>? salesBillSearchResult;
  final String? message;
  final BillModel? salesReturnSuccess;
  final double totalBillsAmount;

  SalesReturnState({
    this.isLoading,
    required this.salesBillList,
    this.salesBillSearchResult,
    this.message,
    this.salesReturnSuccess,
    required this.totalBillsAmount,
  });

  factory SalesReturnState.initial() {
    return SalesReturnState(
      salesBillList: [],
      totalBillsAmount: 0.0,
    );
  }

  SalesReturnState copyWith({
    bool? isLoading,
    List<BillModel>? salesBillList,
    List<BillModel>? salesBillSearchResult,
    String? message,
    BillModel? salesReturnSuccess,
    double? totalBillsAmount,
  }) {
    return SalesReturnState(
      isLoading: isLoading,
      salesBillList: salesBillList ?? this.salesBillList,
      salesBillSearchResult:
          salesBillSearchResult ?? this.salesBillSearchResult,
      message: message ?? this.message,
      salesReturnSuccess: salesReturnSuccess,
      totalBillsAmount: totalBillsAmount ?? this.totalBillsAmount,
    );
  }
}
