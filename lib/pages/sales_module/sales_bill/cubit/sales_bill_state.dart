part of 'sales_bill_cubit.dart';

class SalesBillState {
  final bool? isLoading;
  final List<BillModel>? salesBillList;
  final List<BillModel>? salesBillSearchResult;
  final String? message;
  final BillModel? salesReturnSuccess;
  final double totalBillsAmount;
  final double totalDiscountAmount;

  SalesBillState({
    this.isLoading,
    required this.salesBillList,
    this.salesBillSearchResult,
    this.message,
    this.salesReturnSuccess,
    required this.totalBillsAmount,
    required this.totalDiscountAmount,
  });

  factory SalesBillState.initial() {
    return SalesBillState(
      salesBillList: [],
      totalBillsAmount: 0.0,
      totalDiscountAmount: 0.0,
    );
  }

  SalesBillState copyWith({
    bool? isLoading,
    List<BillModel>? salesBillList,
    List<BillModel>? salesBillSearchResult,
    String? message,
    BillModel? salesReturnSuccess,
    double? totalBillsAmount,
    double? totalDiscountAmount,
  }) {
    return SalesBillState(
      isLoading: isLoading,
      salesBillList: salesBillList ?? this.salesBillList,
      salesBillSearchResult:
          salesBillSearchResult ?? this.salesBillSearchResult,
      message: message ?? this.message,
      salesReturnSuccess: salesReturnSuccess,
      totalBillsAmount: totalBillsAmount ?? this.totalBillsAmount,
      totalDiscountAmount: totalDiscountAmount ?? this.totalDiscountAmount,
    );
  }
}
