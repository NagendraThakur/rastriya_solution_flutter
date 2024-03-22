// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'terminal_cubit.dart';

class TerminalState {
  final List<TerminalModel> terminalList;
  final List<StoreModel> storeList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  TerminalState(
      {required this.terminalList,
      required this.storeList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory TerminalState.initial() {
    return TerminalState(terminalList: [], storeList: []);
  }

  TerminalState copyWith({
    List<TerminalModel>? terminalList,
    List<StoreModel>? storeList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return TerminalState(
      terminalList: terminalList ?? this.terminalList,
      storeList: storeList ?? this.storeList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
