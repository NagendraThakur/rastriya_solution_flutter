// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pos_cubit.dart';

class PosState {
  final BillModel? billSavedSuccessfully;
  final OrderBillModel? salesOrderBill;
  final double totalAmount;
  final double? paidAmount;
  final double discountPercentage;
  final double discountAmount;
  final double orderQuantity;
  final double subtotal;
  final double quantity;
  final bool? isLoading;
  final String? message;
  final String? toastMessage;
  final List<List<ProductModel>>? savedOrderList;
  final ProductModel? selectedProduct;
  final LedgerModel? customer;
  final LoyaltyMemberModel? loyaltyMember;
  final List<PaymentModeModel>? paymentModeList;
  final List<PaymentModeModel>? paidPaymentModeList;
  final bool? exportSales;
  final bool? taxInvoice;
  final bool? ledgerDiscountAssigned;
  final Map<String, List<ProductModel>>? categoryProductList;
  final TableModel? selectedTable;
  final int noOfGuest;
  final List<TableModel> tableList;
  final List<SectionModel> sectionList;
  final List<ProductModel> productList;
  final List<ProductModel>? orderList;

  PosState({
    this.billSavedSuccessfully,
    this.salesOrderBill,
    required this.totalAmount,
    this.paidAmount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.orderQuantity,
    required this.subtotal,
    required this.quantity,
    this.isLoading,
    this.message,
    this.toastMessage,
    required this.productList,
    this.orderList,
    this.savedOrderList,
    this.selectedProduct,
    this.customer,
    this.loyaltyMember,
    this.paymentModeList,
    this.paidPaymentModeList,
    this.exportSales,
    this.taxInvoice,
    this.ledgerDiscountAssigned,
    required this.tableList,
    this.categoryProductList,
    this.selectedTable,
    required this.noOfGuest,
    required this.sectionList,
  });

  factory PosState.initial() {
    return PosState(
        tableList: [],
        sectionList: [],
        productList: [],
        noOfGuest: 1,
        totalAmount: 0,
        paidAmount: 0,
        discountPercentage: 0,
        discountAmount: 0,
        orderQuantity: 0,
        subtotal: 0,
        quantity: 0,
        taxInvoice:
            Config.companyInfo?.taxInvoiceOnlyInPos == "1" ? true : false,
        exportSales: false);
  }

  PosState copyWith({
    List<SectionModel>? sectionList,
    BillModel? billSavedSuccessfully,
    OrderBillModel? salesOrderBill,
    double? quantity,
    bool? isLoading,
    String? message,
    String? toastMessage,
    List<ProductModel>? productList,
    bool? removeOrder,
    List<ProductModel>? orderList,
    double? subtotal,
    double? orderQuantity,
    double? totalAmount,
    double? paidAmount,
    double? discountAmount,
    List<List<ProductModel>>? savedOrderList,
    ProductModel? selectedProduct,
    bool? removeSelectedProduct,
    LedgerModel? customer,
    bool? removeCustomer,
    LoyaltyMemberModel? loyaltyMember,
    bool? removeLoyaltyMember,
    double? discountPercentage,
    List<PaymentModeModel>? paymentModeList,
    List<PaymentModeModel>? paidPaymentModeList,
    bool? removepaidPaymentModeList,
    bool? exportSales,
    bool? taxInvoice,
    List<TableModel>? tableList,
    Map<String, List<ProductModel>>? categoryProductList,
    TableModel? selectedTable,
    bool? removeSelectedTable,
    bool? removeSalesOrderBill,
    int? noOfGuest,
  }) {
    return PosState(
      billSavedSuccessfully: billSavedSuccessfully,
      salesOrderBill: removeSalesOrderBill == true
          ? null
          : salesOrderBill ?? this.salesOrderBill,
      quantity: quantity ?? 1,
      isLoading: isLoading,
      message: message,
      toastMessage: toastMessage,
      productList: productList ?? this.productList,
      // if remove order is true then null order list is sent else previous list is sent
      orderList: removeOrder == true ? orderList : orderList ?? this.orderList,
      savedOrderList: savedOrderList ?? this.savedOrderList,
      selectedProduct: removeSelectedProduct == true
          ? selectedProduct
          : selectedProduct ?? this.selectedProduct,
      customer: removeCustomer == true ? customer : customer ?? this.customer,
      loyaltyMember: removeLoyaltyMember == true
          ? loyaltyMember
          : loyaltyMember ?? this.loyaltyMember,
      subtotal: subtotal ?? this.subtotal,
      orderQuantity: orderQuantity ?? this.orderQuantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      paymentModeList: paymentModeList ?? this.paymentModeList,
      paidPaymentModeList: removepaidPaymentModeList == true
          ? paidPaymentModeList
          : paidPaymentModeList ?? this.paidPaymentModeList,
      exportSales: exportSales ?? this.exportSales,
      taxInvoice: taxInvoice ?? this.taxInvoice,
      tableList: tableList ?? this.tableList,
      categoryProductList: categoryProductList ?? this.categoryProductList,
      selectedTable: removeSelectedTable == true
          ? null
          : selectedTable ?? this.selectedTable,
      noOfGuest: noOfGuest ?? this.noOfGuest,
      sectionList: sectionList ?? this.sectionList,
    );
  }
}
