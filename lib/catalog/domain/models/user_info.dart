
class UserInfoAuth {
  var id;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? gender;
  String? accessToken;
  String? refreshToken;


  UserInfoAuth(
      {
        this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.image,
        this.gender,
        this.accessToken,
        this.refreshToken
      });

  UserInfoAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    accessToken = json['accessToken'];
    gender = json['gender'];
    image = json['image'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['refreshToken'] = refreshToken;
    data['accessToken'] = accessToken;
    data['gender'] = gender;
    data['image'] = image;
    return data;
  }
}
