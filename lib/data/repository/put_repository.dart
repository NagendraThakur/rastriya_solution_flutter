import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/api/api.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';

class PutRepository {
  API api = API();
  static String changePassword = "/api/v2/user/password";
  static String paymentMode = "/api/v2/pos/pos-payment-mode";
  static String salesBillHistory = "/api/v2/pos/sales-bill-history";
  static String userBasic = "/api/v2/user/basic";

  Future<dynamic> putRequest(
      {required String path, String? editId, required Object body}) async {
    try {
      String editPath = path;
      if (editId != null) {
        editPath = "$path/$editId";
      }

      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${Config.userAuthenticationToken}",
        "company-id": Config.companyInfo!.id
      };
      Response response = await api.sendRequest.put(
        editPath,
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
}
