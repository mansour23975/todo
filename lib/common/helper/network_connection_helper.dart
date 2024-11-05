import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnectionHelper {
  static Future<String?> checkNetworkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      return null;
    } else {
      return "no_internet_connection".tr();
    }
  }
}