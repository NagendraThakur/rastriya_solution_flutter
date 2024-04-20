import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:rastriya_solution_flutter/constants/config.dart';
import 'package:rastriya_solution_flutter/data/repository/api/api.dart';
import 'package:rastriya_solution_flutter/helper/toast.dart';

class GetRepository {
  API api = API();
  static String brand = "/api/v2/inventory-setup/brands";
  static String loggedinUserInfo = "/api/v2/user/info";
  static String accountPermission = "/api/v2/account-setup/permissions";
  static String companySetup = "/api/v2/company-setup";
  static String posTerminal = "/api/v2/account-setup/pos-terminal";
  static String logoutAllDevices = "/api/v2/auth/logout-all-devices";
  static String ledger = "/api/v2/accounts-and-ledgers/account-setup/ledgers";
  static String fiscalYear = "/api/v2/fiscal-year";
  static String store = "/api/v2/account-setup/store";
  static String employee = "/api/v2/account-setup/employee-management";
  static String category = "/api/v2/inventory-setup/category";
  static String unit = "/api/v2/inventory-setup/units";

  static String paymentMode = "/api/v2/pos/pos-payment-mode";
  static String paymentModeImage = "/api/v2/misc/all-payment-images";
  static String printStation = "/api/v2/pos/print-station";
  static String table = "/api/v2/inventory-setup/tables";
  static String section = "/api/v2/inventory-setup/sections";
  static String product = "/api/v2/inventory-setup/product";
  static String searchProduct = "/api/v2/inventory-setup/product/search";
  static String searchBarcodeProduct =
      "/api/v2/inventory-setup/product/search-barcode";
  static String searchLedger =
      "/api/v2/accounts-and-ledgers/account-setup/ledgers/search";
  static String loyaltyMember = "/api/v2/discount-and-loyalty/loyalty";
  static String loyaltyMemberDiscount =
      "/api/v2/discount-and-loyalty/loyalty/discount";
  static String searchLoyaltyMember =
      "/api/v2/discount-and-loyalty/loyalty/search";
  static String batch = "/api/v2/inventory-setup/batch";
  static String salesBill = "/api/v2/pos/sales-bill";
  static String salesReturn = "/api/v2/pos/sales-return";
  static String salesBillHistory = "/api/v2/pos/sales-bill-history";
  static String voidReason = "/api/v2/pos/void-reason";

  //purchase
  static String purchaseOrder = "/api/v2/pos/purchase-order";
  static String purchaseBill = "/api/v2/pos/purchase-bill";

  //Reports
  static String dailyProductReport = "/api/v2/reports/sales/product";
  static String voidOrderReport = "/api/v2/reports/sales/void";
  static String fAndBOrderReport = "/api/v2/reports/sales/order";
  static String collectionReport = "/api/v2/reports/sales/collection";

  Future<dynamic> getRequest({
    required String path,
    Map<String, dynamic>? additionalHeader,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Map<String, dynamic> headers = {
        "Authorization": "Bearer ${Config.userAuthenticationToken}"
      };
      // Merge additional headers if they are not null or empty
      if (additionalHeader != null && additionalHeader.isNotEmpty) {
        headers.addAll(additionalHeader);
      }
      Response response = await api.sendRequest.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } catch (ex) {
      if (ex is DioException && ex.error is SocketException) {
        showToast(message: "No Internet Connection");
      }
      log(ex.toString());
      return null;
    }
  }
}
