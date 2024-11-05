class InvalidField {
  String? field;
  String? message;

  InvalidField({this.field, this.message});

  InvalidField.fromJson(dynamic json) {
    field = json["field"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["field"] = field;
    map["message"] = message;
    return map;
  }
}
