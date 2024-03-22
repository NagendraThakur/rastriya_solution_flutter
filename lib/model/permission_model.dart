class PermissionModel {
  final String id;
  final String companyId;
  final String userId;
  final String isAdmin;
  final String isActive;
  final String documentPostingLevel;
  final String flag;
  final String nickName;
  final String exportReport;
  final String printReport;
  final String posUser;
  final String creditSales;
  final String rateChange;
  final String employeeType;
  final String storeId;

  final String terminalId;

  PermissionModel({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.isAdmin,
    required this.isActive,
    required this.documentPostingLevel,
    required this.flag,
    required this.nickName,
    required this.exportReport,
    required this.printReport,
    required this.posUser,
    required this.creditSales,
    required this.rateChange,
    required this.employeeType,
    required this.storeId,
    required this.terminalId,
  });

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    final base = json['permissions']['base'];

    return PermissionModel(
      id: base['id'].toString(),
      companyId: base['company_id'].toString(),
      userId: base['user_id'].toString(),
      isAdmin: base['is_admin'].toString(),
      isActive: base['is_active'].toString(),
      documentPostingLevel: base['document_posting_level'].toString(),
      flag: base['flag'].toString(),
      nickName: base['nick_name'].toString(),
      exportReport: base['export_report'].toString(),
      printReport: base['print_report'].toString(),
      posUser: base['pos_user'].toString(),
      creditSales: base['credit_sales'].toString(),
      rateChange: base['rate_change'].toString(),
      employeeType: base['employee_type'].toString(),
      storeId: base['store_id'].toString(),
      terminalId: base['terminal_id'].toString(),
    );
  }
}
