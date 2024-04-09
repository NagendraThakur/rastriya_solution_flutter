part of 'void_product_cubit.dart';

class VoidProductState {
  final List<VoidReportModel> voidReportList;
  final bool? isLoading;
  final String? message;

  VoidProductState(
      {required this.voidReportList, this.isLoading, this.message});

  factory VoidProductState.initial() {
    return VoidProductState(voidReportList: []);
  }

  VoidProductState copyWith({
    List<VoidReportModel>? voidReportList,
    bool? isLoading,
    String? message,
  }) {
    return VoidProductState(
      voidReportList: voidReportList ?? this.voidReportList,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}
