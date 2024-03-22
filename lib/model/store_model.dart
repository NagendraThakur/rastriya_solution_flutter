class StoreModel {
  final String? id;
  final String? companyId;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? contactPersonName;
  final String? contactPersonPhone;
  final String? numberSeriesPrefix;
  final String? customerCode;

  StoreModel({
    this.id,
    this.companyId,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.contactPersonName,
    this.contactPersonPhone,
    this.numberSeriesPrefix,
    this.customerCode,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'].toString(),
      companyId: json['company_id'].toString(),
      name: json['name'],
      address: json['address'],
      phone: json['phone'].toString(),
      email: json['email'],
      contactPersonName: json['contact_person_name'],
      contactPersonPhone: json['contact_person_phone'].toString(),
      numberSeriesPrefix: json['number_series_prefix'],
      customerCode: json['customer_code'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'contact_person_name': contactPersonName,
      'contact_person_phone': contactPersonPhone,
      'number_series_prefix': numberSeriesPrefix,
      'customer_code': customerCode,
    };
  }
}
