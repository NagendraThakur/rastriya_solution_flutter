import 'package:rastriya_solution_flutter/model/assets_model.dart';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:rastriya_solution_flutter/model/user_model.dart';

class AuthModel {
  final String status;
  final String message;
  final String userAuthenticationToken;
  final List<CompanyModel> userJoinedCompanyLists;
  final User user;
  final AssetsModel? assets;

  AuthModel({
    required this.status,
    required this.message,
    required this.userAuthenticationToken,
    required this.userJoinedCompanyLists,
    required this.user,
    required this.assets,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('userAuthenticationToken')) {
      // Handle the second response format
      final List<dynamic> companyList = json['userJoinedCompanyLists'] ?? [];
      final List<CompanyModel> companies = companyList.map((companyJson) {
        return CompanyModel.fromJson(companyJson);
      }).toList();

      return AuthModel(
        status: json['status'] ?? "",
        message: json['message'] ?? "",
        userAuthenticationToken: json['userAuthenticationToken'] ?? "",
        userJoinedCompanyLists: companies,
        user: User.fromJson(json['user'] ?? {}),
        assets:
            json["assets"] != null ? AssetsModel.fromMap(json["assets"]) : null,
      );
    } else {
      // Handle the first response format
      return AuthModel(
        status: json['status'] ?? "",
        message: json['message'] ?? "",
        userAuthenticationToken: "",
        userJoinedCompanyLists: [],
        user: User.fromJson(json['user'] ?? {}),
        assets:
            json["assets"] != null ? AssetsModel.fromMap(json["assets"]) : null,
      );
    }
  }

  // Getter method to retrieve userJoinedCompanyLists
  List<CompanyModel> getUserJoinedCompanyLists() {
    return userJoinedCompanyLists;
  }

  // Getter method to retrieve userAuthenticationToken
  String getUserAuthenticationToken() {
    return userAuthenticationToken;
  }

  User getUser() {
    return user;
  }

  AuthModel copyWith({
    String? status,
    String? message,
    String? userAuthenticationToken,
    List<CompanyModel>? userJoinedCompanyLists,
    User? user,
    AssetsModel? assets,
  }) {
    return AuthModel(
      status: status ?? this.status,
      message: message ?? this.message,
      userAuthenticationToken:
          userAuthenticationToken ?? this.userAuthenticationToken,
      userJoinedCompanyLists:
          userJoinedCompanyLists ?? this.userJoinedCompanyLists,
      user: user ?? this.user,
      assets: assets ?? this.assets,
    );
  }
}
