import '../../catalog/domain/models/user_info.dart';
import '../helper/shared_preferences_helper.dart';
import 'app_config.dart';

class SharedData {
  static SharedData shared = SharedData();


  UserInfoAuth? user;
  String? token;
  clearData() {
    user = null;
  }



  updateUserInfo({required UserInfoAuth user}){
    SharedPref().save(PrefsKeys.userTAG, user);
    SharedData.shared.user = user;
  }


  saveCurrentUser({required UserInfoAuth user, required String? token}) {
    SharedPref().save(PrefsKeys.userTAG, user);
    //toDo needed from backend (token in user info)
    SharedPref().save(PrefsKeys.tokenTAG, token);
    SharedData.shared.user = user;
    SharedData.shared.token = token;

  }




  bool isGuest() {
    return SharedData.shared.token == null;
  }




}