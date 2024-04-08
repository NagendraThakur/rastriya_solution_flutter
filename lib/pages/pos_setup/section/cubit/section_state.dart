part of 'section_cubit.dart';

class SectionState {
  final List<SectionModel> sectionList;
  final bool? isLoading;
  final String? message;
  final List<StoreModel> storeList;

  SectionState({
    required this.sectionList,
    this.isLoading,
    this.message,
    required this.storeList,
  });

  factory SectionState.initial() {
    return SectionState(sectionList: [], storeList: []);
  }

  SectionState copyWith({
    List<SectionModel>? sectionList,
    bool? isLoading,
    String? message,
    List<StoreModel>? storeList,
  }) {
    return SectionState(
      sectionList: sectionList ?? this.sectionList,
      isLoading: isLoading,
      message: message ?? this.message,
      storeList: storeList ?? this.storeList,
    );
  }
}
