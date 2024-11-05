import 'package:todo_flutter_app/catalog/domain/models/user_info.dart';

class LoginResponse {
  UserInfoAuth? user;

  LoginResponse({this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json != null ? UserInfoAuth?.fromJson(json) : null;
  }
}
