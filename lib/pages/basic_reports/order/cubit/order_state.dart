part of 'order_cubit.dart';

class OrderState {
  final bool? isLoading;
  final String? message;
  final List<OrderReportModel> orderReportList;

  OrderState({this.isLoading, this.message, required this.orderReportList});

  factory OrderState.initial() {
    return OrderState(orderReportList: []);
  }

  OrderState copyWith({
    bool? isLoading,
    String? message,
    List<OrderReportModel>? orderReportList,
  }) {
    return OrderState(
      isLoading: isLoading,
      message: message,
      orderReportList: orderReportList ?? this.orderReportList,
    );
  }
}
