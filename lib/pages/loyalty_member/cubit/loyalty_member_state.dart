part of 'loyalty_member_cubit.dart';

class LoyaltyMemberState {
  final List<LoyaltyMemberModel>? loyaltyMemberList;
  final bool? isLoading;
  final bool? isFetching;
  final String? message;

  LoyaltyMemberState(
      {required this.loyaltyMemberList,
      this.isLoading,
      this.isFetching,
      this.message});

  factory LoyaltyMemberState.initial() {
    return LoyaltyMemberState(loyaltyMemberList: []);
  }

  LoyaltyMemberState copyWith({
    List<LoyaltyMemberModel>? loyaltyMemberList,
    bool? isLoading,
    bool? isFetching,
    String? message,
  }) {
    return LoyaltyMemberState(
      loyaltyMemberList: loyaltyMemberList ?? this.loyaltyMemberList,
      isLoading: isLoading,
      isFetching: isFetching,
      message: message,
    );
  }
}
