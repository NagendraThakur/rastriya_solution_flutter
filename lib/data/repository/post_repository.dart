import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/api/api.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';

class PostRepository {
  API api = API();
  static String googleAuth = "/api/v2/auth/google";
  static String classicAuth = "/api/v2/auth/login";
  static String companySetup = "/api/v2/company-setup";
  static String paymentMode = "/api/v2/pos/pos-payment-mode";
  static String printStation = "/api/v2/pos/print-station";
  static String saleBill = "/api/v2/pos/sales-bill";
  static String salesReturn = "/api/v2/pos/sales-return";
  static String loyaltyMember = "/api/v2/discount-and-loyalty/loyalty";
  static String forgotPassword = "/api/v2/auth/forgot-password";
  static String registerUser = "/api/v2/auth/register";
  static String salesOrder = "/api/v2/pos/sales-order";
  static String salesVoid = "/api/v2/pos/sales-void";
  static String purchaseOrder = "/api/v2/pos/purchase-order";
  static String purchaseBill = "/api/v2/pos/purchase-bill";

  Future<dynamic> postRequest(
      {required String path, String? editId, required Object body}) async {
    try {
      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${Config.userAuthenticationToken}",
        "company-id": Config.companyInfo!.id
      };
      editId != null && editId.isNotEmpty ? path = "$path/$editId" : null;
      Response response = await api.sendRequest.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        showToast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }

  Future<dynamic> companyPost(
      {required String path, String? editId, required Object body}) async {
    try {
      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${Config.userAuthenticationToken}",
      };
      editId != null && editId.isNotEmpty ? path = "$path/$editId" : null;
      Response response = await api.sendRequest.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        showToast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }

  Future<dynamic> authPostRequest(
      {required String path, required Object body}) async {
    try {
      Response response = await api.sendRequest.post(path, data: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return responseData;
      } else {
        return null;
      }
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        showToast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }
}
