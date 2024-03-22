class EmployeeModel {
  final String? id; // Converted to String?
  final String? companyId;
  final String? userId;
  final bool? isAdmin;
  final bool? isActive;
  final String? documentPostingLevel;
  final String? flag; // Converted to String?
  final String? nickName;
  final String? exportReport; // Converted to String?
  final String? printReport; // Converted to String?
  final bool? posUser; // Converted to String?
  final bool? creditSales; // Converted to String?
  final bool? rateChange; // Converted to String?
  final String? employeeType;
  final String? storeId;
  final String? terminalId; // Converted to String?
  final String? title;
  final String? fullName;
  final String? username;
  final String? address;
  final String? phone;
  final String? email;
  final dynamic
      password; // It's better to handle passwords securely, consider using a proper encryption method
  final String? avatar;
  final String? status; // Converted to String?
  final String? licenseApproved; // Converted to String?
  final String? licenseType;
  final String? proType; // Converted to String?
  final String? emailVerificationToken;
  final dynamic rememberToken;
  final String? secondaryAddress;
  final String? city; // Nullable
  final dynamic stateId; // Nullable
  final dynamic districtId; // Nullable
  final String? secondaryPhone; // Nullable
  final String? gender; // Nullable
  final String? dateOfBirth;
  final String? maritalStatus; // Nullable
  final dynamic educationLevel; // Nullable
  final dynamic workExperience; // Nullable
  final dynamic deletedAt; // Nullable
  final String? linkId; // Converted to String?
  final String? storeName;
  final String? terminalName;

  EmployeeModel({
    this.id,
    this.companyId,
    this.userId,
    this.isAdmin,
    this.isActive,
    this.documentPostingLevel,
    this.flag,
    this.nickName,
    this.exportReport,
    this.printReport,
    this.posUser,
    this.creditSales,
    this.rateChange,
    this.employeeType,
    this.storeId,
    this.terminalId,
    this.title,
    this.fullName,
    this.username,
    this.address,
    this.phone,
    this.email,
    this.password,
    this.avatar,
    this.status,
    this.licenseApproved,
    this.licenseType,
    this.proType,
    this.emailVerificationToken,
    this.rememberToken,
    this.secondaryAddress,
    this.city,
    this.stateId,
    this.districtId,
    this.secondaryPhone,
    this.gender,
    this.dateOfBirth,
    this.maritalStatus,
    this.educationLevel,
    this.workExperience,
    this.deletedAt,
    this.linkId,
    this.storeName,
    this.terminalName,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id']?.toString(), // Convert int? to String?
      companyId: json['company_id']?.toString(),
      userId: json['user_id']?.toString(),
      isAdmin: json['is_admin']?.toString() == "1" ? true : false,
      isActive: json['is_active']?.toString() == "1" ? true : false,
      documentPostingLevel: json['document_posting_level'],
      flag: json['flag']?.toString(), // Convert int? to String?
      nickName: json['nick_name'],
      exportReport:
          json['export_report']?.toString(), // Convert int? to String?
      printReport: json['print_report']?.toString(), // Convert int? to String?
      posUser: json['pos_user']?.toString() == "1"
          ? true
          : false, // Convert int? to String?
      creditSales: json['credit_sales']?.toString() == "1"
          ? true
          : false, // Convert int? to String?
      rateChange: json['rate_change']?.toString() == "1"
          ? true
          : false, // Convert int? to String?
      employeeType: json['employee_type'],
      storeId: json['store_id']?.toString(),
      terminalId: json['terminal_id']?.toString(), // Convert int? to String?
      title: json['title'],
      fullName: json['full_name'],
      username: json['username'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      password: json['password'],
      avatar: json['avatar'],
      status: json['status']?.toString(), // Convert int? to String?
      licenseApproved:
          json['license_approved']?.toString(), // Convert int? to String?
      licenseType: json['license_type'],
      proType: json['pro_type']?.toString(), // Convert int? to String?
      emailVerificationToken: json['email_verification_token'],
      rememberToken: json['remember_token'],
      secondaryAddress: json['secondary_address'],
      city: json['city'],
      stateId: json['state_id'],
      districtId: json['district_id'],
      secondaryPhone: json['secondary_phone'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      maritalStatus: json['marital_status'],
      educationLevel: json['education_level'],
      workExperience: json['work_experience'],
      deletedAt: json['deleted_at'],
      linkId: json['link_id']?.toString(), // Convert int? to String?
      storeName: json['store_name'],
      terminalName: json['terminal_name'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'user_id': userId,
      'is_admin': isAdmin == true ? "1" : "0",
      'is_active': isActive == true ? "1" : "0",
      'document_posting_level': documentPostingLevel,
      'flag': flag,
      'nick_name': nickName,
      'export_report': exportReport,
      'print_report': printReport,
      'pos_user': posUser == true ? "1" : "0",
      'credit_sales': creditSales == true ? "1" : "0",
      'rate_change': rateChange == true ? "1" : "0",
      'employee_type': employeeType,
      'store_id': storeId,
      'terminal_id': terminalId,
      'title': title,
      'full_name': fullName,
      'username': username,
      'address': address,
      'phone': phone,
      'email': email,
      'password': password,
      'avatar': avatar,
      'status': status,
      'license_approved': licenseApproved,
      'license_type': licenseType,
      'pro_type': proType,
      'email_verification_token': emailVerificationToken,
      'remember_token': rememberToken,
      'secondary_address': secondaryAddress,
      'city': city,
      'state_id': stateId,
      'district_id': districtId,
      'secondary_phone': secondaryPhone,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'marital_status': maritalStatus,
      'education_level': educationLevel,
      'work_experience': workExperience,
      'deleted_at': deletedAt,
      'link_id': linkId,
      'store_name': storeName,
      'terminal_name': terminalName,
    };
  }
}
