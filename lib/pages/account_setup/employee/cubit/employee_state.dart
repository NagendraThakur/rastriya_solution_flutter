part of 'employee_cubit.dart';

class EmployeeState {
  final List<EmployeeModel> employeeList;
  final List<StoreModel> storeList;
  final List<TerminalModel> terminalList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  EmployeeState(
      {required this.employeeList,
      required this.storeList,
      required this.terminalList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory EmployeeState.initial() {
    return EmployeeState(
      employeeList: [],
      storeList: [],
      terminalList: [],
    );
  }

  EmployeeState copyWith({
    List<EmployeeModel>? employeeList,
    List<StoreModel>? storeList,
    List<TerminalModel>? terminalList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return EmployeeState(
      employeeList: employeeList ?? this.employeeList,
      storeList: storeList ?? this.storeList,
      terminalList: terminalList ?? this.terminalList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
