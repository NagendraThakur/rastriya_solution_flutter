class TerminalModel {
  final String? id;
  final String? storeId;
  final String? storeName;
  final String? terminalName;
  final String? billPrinterName;
  final String? companyId;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? contactPersonName;
  final String? contactPersonPhone;
  final String? numberSeriesPrefix;
  final String? customerCode;

  TerminalModel({
    this.id,
    this.storeId,
    this.storeName,
    this.terminalName,
    this.billPrinterName,
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

  factory TerminalModel.fromJson(Map<String, dynamic> json) {
    return TerminalModel(
      id: json['id'].toString(),
      storeId: json['store_id'].toString(),
      storeName: json['store_name'].toString(),
      terminalName: json['terminal_name'],
      billPrinterName: json['bill_printer_name'],
      companyId: json['company_id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      contactPersonName: json['contact_person_name'],
      contactPersonPhone: json['contact_person_phone'],
      numberSeriesPrefix: json['number_series_prefix'],
      customerCode: json['customer_code'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store': storeId,
      'store_name': storeName,
      'terminal_name': terminalName,
      'bill_printer_name': billPrinterName,
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
