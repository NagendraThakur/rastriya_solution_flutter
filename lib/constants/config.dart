import '../model/company_model.dart';
import '../model/permission_model.dart';
import '../model/store_model.dart';
import '../model/terminal_model.dart';

class Config {
  static String? userAuthenticationToken;
  static CompanyModel? companyInfo;
  static PermissionModel? permissionInfo;
  static TerminalModel? terminalInfo;
  static StoreModel? storeInfo;
  static String? assetsUpload;

  static void clear() {
    userAuthenticationToken = null;
    companyInfo = null;
    permissionInfo = null;
    terminalInfo = null;
    assetsUpload = null;
  }
}
