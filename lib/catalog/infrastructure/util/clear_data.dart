import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/config/shared_data.dart';

class ClearData {
  static clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    SharedData.shared.clearData();
    await preferences.clear();
  }
}
