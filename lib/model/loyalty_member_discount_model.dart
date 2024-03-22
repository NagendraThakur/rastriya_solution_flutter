class LoyaltyMemberDiscountModel {
  String productId;
  double discount;

  LoyaltyMemberDiscountModel({required this.productId, required this.discount});

  factory LoyaltyMemberDiscountModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyMemberDiscountModel(
      productId: json['product_id'].toString(),
      discount: double.parse(json['discount'].toString()),
    );
  }
}
