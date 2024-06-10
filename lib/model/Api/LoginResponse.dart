import '../../Services/BaseResponse.dart';

class LoginModelResponse extends BaseResponse{
  List<String>? email;
  List<String>? password;
  String? message;
  bool? status;

  LoginModelResponse(  {this.email, this.password});

  LoginModelResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
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
