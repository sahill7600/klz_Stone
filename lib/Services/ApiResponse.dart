import 'BaseResponse.dart';

class ApiResponse extends BaseResponse {
  bool? status;
  String? message;

  ApiResponse(this.status, this.message);

  ApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }

  @override
  String getMessage() {
    return message!;
  }

  @override
  bool isSuccess() {
    return status == 1;
  }

  bool isUpdate() {
    return status == 2;
  }

  bool isExpired() {
    return status == 3;
  }
}
