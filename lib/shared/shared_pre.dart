import 'dart:convert';
import 'package:rastriya_solution_flutter/model/company_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void savePreference({required String key, required String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

void deletePreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<bool> hasPreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}

Future<String?> getPreference({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

Future<CompanyModel?> getSelectedCompany() async {
  final prefs = await SharedPreferences.getInstance();
  final companyJson = prefs.getString('company');

  if (companyJson != null) {
    final Map<String, dynamic> jsonMap = json.decode(companyJson);
    return CompanyModel.fromJson(jsonMap);
  } else {
    return null;
  }
}

Future<void> deleteAllSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final keys = prefs.getKeys(); // Get all keys

  // Loop through keys and remove them
  for (String key in keys) {
    await prefs.remove(key);
  }
}
