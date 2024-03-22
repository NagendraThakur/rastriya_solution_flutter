class LedgerModel {
  final String? id;
  final String? code;
  final String name;
  final String? ledgerType;
  final String? bank;
  final String? cash;
  final String? panNo;
  final String? billingAddress1;
  final String? billingPhone1;
  final String? billingEmail;
  final String? contactDescription;
  final String? contactPersonPhone;
  final String? createdAt;
  final String? updatedAt;
  final String? trialGroupId;
  final String? shortName;
  final String? billingCity1;
  final String? billingStreetName1;
  final String? logoImage;
  final String? shippingAddress1;
  final String? shippingPhone1;
  final String? shippingCity1;
  final String? shippingStreetName1;
  final String? creditLimitAmount;

  LedgerModel({
    this.id,
    this.code,
    required this.name,
    this.ledgerType,
    this.bank,
    this.cash,
    this.panNo,
    this.billingAddress1,
    this.billingPhone1,
    this.billingEmail,
    this.contactDescription,
    this.contactPersonPhone,
    this.createdAt,
    this.updatedAt,
    this.trialGroupId,
    this.shortName,
    this.billingCity1,
    this.billingStreetName1,
    this.logoImage,
    this.shippingAddress1,
    this.shippingPhone1,
    this.shippingCity1,
    this.shippingStreetName1,
    this.creditLimitAmount,
  });

  factory LedgerModel.fromJson(Map<String, dynamic> json) {
    return LedgerModel(
      id: json['id'].toString(),
      code: json['code'].toString(),
      name: json['name'].toString(),
      ledgerType: json['ledger_type'].toString(),
      bank: json['bank'].toString(),
      cash: json['cash'].toString(),
      panNo: json['pan_no'],
      billingAddress1: json['billing_address1'],
      billingPhone1: json['billing_phone1'],
      billingEmail: json['billing_email'],
      contactDescription: json['contact_description'],
      contactPersonPhone: json['contact_person_phone'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      trialGroupId: json['trial_group_id'].toString(),
      shortName: json['short_name'],
      billingCity1: json['billing_city1'],
      billingStreetName1: json['billing_street_name1'],
      logoImage: json['logo_image'],
      shippingAddress1: json['shipping_address1'],
      shippingPhone1: json['shipping_phone1'].toString(),
      shippingCity1: json['shipping_city1'],
      shippingStreetName1: json['shipping_street_name1'],
      creditLimitAmount: json['credit_limit_amount'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'ledger_type': ledgerType,
      'bank': bank,
      'cash': cash,
      'pan_no': panNo,
      'billing_address1': billingAddress1,
      'billing_phone1': billingPhone1,
      'billing_email': billingEmail,
      'contact_description': contactDescription,
      'contact_person_phone': contactPersonPhone,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'trial_group_id': trialGroupId,
      'short_name': shortName,
      'billing_city1': billingCity1,
      'billing_street_name1': billingStreetName1,
      'logo_image': logoImage,
      'shipping_address1': shippingAddress1,
      'shipping_phone1': shippingPhone1,
      'shipping_city1': shippingCity1,
      'shipping_street_name1': shippingStreetName1,
      'credit_limit_amount': creditLimitAmount,
    };
  }
}
