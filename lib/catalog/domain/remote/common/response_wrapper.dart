import 'response_type.dart';
import 'errors.dart';

class ResponseWrapper<T> {
  ResponseWrapper({
    this.errors,
    this.code,
    this.responseType,
    this.message,
    this.title,
    this.data,
    this.status,
  });

  ResponseType? responseType;
  Errors? errors;
  T? data;
  bool? status;
  String? code;
  String? message;
  String? title;

  factory ResponseWrapper.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) => ResponseWrapper(
        code: json["code"],
        message: json["message"],
        status: json["success"],
        title: json["title"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        data: json["data"] == null ? null : create(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
        "title": title,
        "success": status,
        "errors": errors,
      };
}
