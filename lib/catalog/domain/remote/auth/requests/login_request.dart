class LoginRequest {
  String? email;
  String? password;

  LoginRequest({this.email, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = email;
    data['password'] = password;
    return data;
  }
}
