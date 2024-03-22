import 'package:rastriya_solution_flutter/model/fiscal_year_model.dart';

class CompanyModel {
  final String id;
  final String companyName;
  final String printTitle;
  final String companyAddress;
  final String companyPhone;
  final String? companyPan;
  final String companyEmail;
  final String companyRegion;
  final String companyCategory;
  final String industryId;
  final String? companyIdentifier;
  final String? companyWebsite;
  final String companyLogo;
  final String? fiscalYearId;
  final String isVatRegistered;
  final String isTaxInvoiceOnly;
  final String createdAt;
  final String updatedAt;
  final FiscalYearModel? fiscalYearInfo;
  final String? negativeInventory;
  final String? billNarrations;
  final String? taxInvoiceOnlyInPos;
  final String? showRemarkSections;
  final String? doubleCopyForTaxInvoice;
  final String? termsAndConditions;
  final String? loyaltyMemberNoSeries;
  final String? customerNoSeries;
  final String? vendorNoSeries;
  final String? dynamicQrPayments;
  final String? printConfirmation;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.printTitle,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyEmail,
    required this.companyRegion,
    required this.companyCategory,
    required this.industryId,
    required this.companyLogo,
    required this.isVatRegistered,
    required this.isTaxInvoiceOnly,
    required this.createdAt,
    required this.updatedAt,
    this.companyPan,
    this.companyIdentifier,
    this.companyWebsite,
    this.fiscalYearId,
    this.fiscalYearInfo, // Initialize the new field
    this.negativeInventory,
    this.billNarrations,
    this.taxInvoiceOnlyInPos,
    this.showRemarkSections,
    this.doubleCopyForTaxInvoice,
    this.termsAndConditions,
    this.loyaltyMemberNoSeries,
    this.customerNoSeries,
    this.vendorNoSeries,
    this.dynamicQrPayments,
    this.printConfirmation,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'].toString(),
      companyName: json['company_name'].toString(),
      printTitle: json['print_title'].toString(),
      companyAddress: json['company_address'].toString(),
      companyPhone: json['company_phone'].toString(),
      companyPan: json['company_pan']?.toString(),
      companyEmail: json['company_email'].toString(),
      companyRegion: json['company_region'].toString(),
      companyCategory: json['company_category'].toString(),
      industryId: json['industry_id'].toString(),
      companyIdentifier: json['company_identifier']?.toString(),
      companyWebsite: json['company_website']?.toString(),
      companyLogo: json['company_logo'].toString(),
      fiscalYearId: json['fiscal_year_id']?.toString(),
      isVatRegistered: json['is_vat_registered'].toString(),
      isTaxInvoiceOnly: json['is_tax_invoice_only'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      fiscalYearInfo: json['fiscal_year_info'] != null
          ? FiscalYearModel.fromJson(json['fiscal_year_info'])
          : null,
      negativeInventory: json['negative_inventory'].toString(),
      billNarrations: json['bill_narrations']?.toString(),
      taxInvoiceOnlyInPos: json['tax_invoice_only_in_pos'].toString(),
      showRemarkSections: json['show_remark_sections'].toString(),
      doubleCopyForTaxInvoice: json['double_copy_for_tax_invoice'].toString(),
      termsAndConditions: json['terms_and_conditions']?.toString(),
      loyaltyMemberNoSeries: json['loyalty_member_no_series'].toString(),
      customerNoSeries: json['customer_no_series']?.toString(),
      vendorNoSeries: json['vendor_no_series']?.toString(),
      dynamicQrPayments: json['dynamic_qr_payments'].toString(),
      printConfirmation: json['print_confirmation'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'company_name': companyName,
      'print_title': printTitle,
      'company_address': companyAddress,
      'company_phone': companyPhone,
      'company_email': companyEmail,
      'company_region': companyRegion,
      'company_category': companyCategory,
      'industry_id': industryId,
      'company_logo': companyLogo,
      'is_vat_registered': isVatRegistered,
      'is_tax_invoice_only': isTaxInvoiceOnly,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'company_pan': companyPan,
      'company_identifier': companyIdentifier,
      'company_website': companyWebsite,
      'fiscal_year_id': fiscalYearId,
      'fiscal_year_info': fiscalYearInfo?.toJson(), // Serialize fiscalYearInfo
      'negative_inventory': negativeInventory,
      'bill_narrations': billNarrations,
      'tax_invoice_only_in_pos': taxInvoiceOnlyInPos,
      'show_remark_sections': showRemarkSections,
      'double_copy_for_tax_invoice': doubleCopyForTaxInvoice,
      'terms_and_conditions': termsAndConditions,
      'loyalty_member_no_series': loyaltyMemberNoSeries,
      'customer_no_series': customerNoSeries,
      'vendor_no_series': vendorNoSeries,
      'dynamic_qr_payments': dynamicQrPayments,
      'print_confirmation': printConfirmation,
    };

    // Remove null values from the map
    data.removeWhere((key, value) => value == null);
    return data;
  }

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.companyName == companyName &&
        other.printTitle == printTitle &&
        other.companyAddress == companyAddress &&
        other.companyPhone == companyPhone &&
        other.companyPan == companyPan &&
        other.companyEmail == companyEmail &&
        other.companyRegion == companyRegion &&
        other.companyCategory == companyCategory &&
        other.industryId == industryId &&
        other.companyIdentifier == companyIdentifier &&
        other.companyWebsite == companyWebsite &&
        other.companyLogo == companyLogo &&
        other.fiscalYearId == fiscalYearId &&
        other.isVatRegistered == isVatRegistered &&
        other.isTaxInvoiceOnly == isTaxInvoiceOnly &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.fiscalYearInfo == fiscalYearInfo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        printTitle.hashCode ^
        companyAddress.hashCode ^
        companyPhone.hashCode ^
        companyPan.hashCode ^
        companyEmail.hashCode ^
        companyRegion.hashCode ^
        companyCategory.hashCode ^
        industryId.hashCode ^
        companyIdentifier.hashCode ^
        companyWebsite.hashCode ^
        companyLogo.hashCode ^
        fiscalYearId.hashCode ^
        isVatRegistered.hashCode ^
        isTaxInvoiceOnly.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        fiscalYearInfo.hashCode;
  }
}
