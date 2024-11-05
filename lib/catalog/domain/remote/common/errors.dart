import 'invalid_field.dart';

class Errors {
  List<InvalidField?>? invalidFields;
  String? global;

  Errors({this.invalidFields, this.global});

  Errors.fromJson(dynamic json) {
    if (json is List && json.isEmpty) {
      return;
    }
    invalidFields = [];
    global = json['global'];
    json.forEach((field, messages) {
      if (messages is List) {
        for (var message in messages) {
          Map<String, dynamic> fieldJson = {"field": field, "message": message};
          invalidFields?.add(InvalidField.fromJson(fieldJson));
        }
      }
    });
  }

  String? findMessageForField(String fieldName) {
    print("invalidField?.field");
    if (invalidFields != null) {
      for (var invalidField in invalidFields!) {
        print("22");
        print(invalidField?.field);
        if (invalidField?.field == fieldName) {
          return invalidField?.message;
        }
      }
    }
    return null; // Return null if the field is not found
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (invalidFields != null) {
      map["invalid_fields"] = invalidFields?.map((v) => v?.toJson()).toList();
    }

    map['global'] = global;
    return map;
  }
}
