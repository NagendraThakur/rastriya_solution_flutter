class LoyaltyMemberModel {
  final String? id;
  final String? memberCode;
  final String memberName;
  final String? district;
  final String? zone;
  final String? state;
  final String? streetAddress;
  final String? mobileNumber;
  final String? telephoneNumber;
  final String? issueDate;
  final String? gender;
  final String? dateOfBirth;
  final String? emailAddress;
  final String? discountScheme;
  final String? referredBy;

  LoyaltyMemberModel({
    this.id,
    this.memberCode,
    required this.memberName,
    this.district,
    this.zone,
    this.state,
    this.streetAddress,
    this.mobileNumber,
    this.telephoneNumber,
    this.issueDate,
    this.gender,
    this.dateOfBirth,
    this.emailAddress,
    this.discountScheme,
    this.referredBy,
  });

  factory LoyaltyMemberModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyMemberModel(
      id: json['id']?.toString(),
      memberCode: json['member_code'].toString(),
      memberName: json['member_name'],
      district: json['district'],
      zone: json['zone'],
      state: json['state'],
      streetAddress: json['street_address'],
      mobileNumber: json['mobile_number'].toString(),
      telephoneNumber: json['telephone_number'],
      issueDate: json['issue_date'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      emailAddress: json['email_address'],
      discountScheme: json['discount_scheme'],
      referredBy: json['referred_by'],
    );
  }
}
