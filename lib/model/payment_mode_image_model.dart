class PaymentModeImageModel {
  String id;
  String image;
  String isActive;

  PaymentModeImageModel({
    required this.id,
    required this.image,
    required this.isActive,
  });

  factory PaymentModeImageModel.fromJson(Map<String, dynamic> json) {
    return PaymentModeImageModel(
      id: json['id'].toString(),
      image: json['image'].toString(),
      isActive: json['is_active'].toString(),
    );
  }
}
