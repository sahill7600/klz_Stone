import 'package:KLZStone/Services/BaseResponse.dart';

class ContactUsResponse extends BaseResponse{
  String? code;
  String? message;
  Data? data;
  bool? status;

  ContactUsResponse({this.code, this.message, this.data});

  ContactUsResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String getMessage() {
    return message!;
  }

  @override
  bool isSuccess() {
    return status == true;
  }
}

class Data {
  int? status;
  Errors? errors;

  Data({this.status, this.errors});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class Errors {
  String? name;
  String? email;

  Errors({this.name, this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
