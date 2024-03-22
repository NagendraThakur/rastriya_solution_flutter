class User {
  String id;
  String? title;
  String? fullName;
  String username;
  String? address;
  String? phone;
  String email;
  String avatar;
  String status;
  String? licenseApproved;
  String? licenseType;
  String? proType;
  String? emailVerificationToken;
  String? secondaryAddress;
  String? city;
  String? stateId;
  String? districtId;
  String? secondaryPhone;
  String? gender;
  String? dateOfBirth;
  String? maritalStatus;
  String? educationLevel;
  String? workExperience;

  User({
    required this.id,
    this.title,
    this.fullName,
    required this.username,
    this.address,
    this.phone,
    required this.email,
    required this.avatar,
    required this.status,
    this.licenseApproved,
    this.licenseType,
    this.proType,
    this.emailVerificationToken,
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
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      title: json['title'],
      fullName: json['full_name'],
      username: json['username'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      avatar: json['avatar'],
      status: json['status'].toString(),
      licenseApproved: json['license_approved'].toString(),
      licenseType: json['license_type'],
      proType: json['pro_type'].toString(),
      emailVerificationToken: json['email_verification_token'],
      secondaryAddress: json['secondary_address'],
      city: json['city'],
      stateId: json['state_id'].toString(),
      districtId: json['district_id'].toString(),
      secondaryPhone: json['secondary_phone'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      maritalStatus: json['marital_status'],
      educationLevel: json['education_level'],
      workExperience: json['work_experience'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'full_name': fullName,
      'username': username,
      'address': address,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'status': status,
      'license_approved': licenseApproved,
      'license_type': licenseType,
      'pro_type': proType,
      'email_verification_token': emailVerificationToken,
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
    };
  }
}
