part of 'collection_cubit.dart';

class CollectionState {
  final bool? isLoading;
  final String? message;
  final Map<String, dynamic>? report;

  CollectionState({this.report, this.isLoading, this.message});

  factory CollectionState.initial() {
    return CollectionState();
  }

  CollectionState copyWith({
    Map<String, dynamic>? report,
    bool? isLoading,
    String? message,
  }) {
    return CollectionState(
      report: report ?? this.report,
      isLoading: isLoading,
      message: message,
    );
  }
}
