
class ErrorParsingModel {
  int? code;
  String? message;
  Map<String,dynamic>? action;

  ErrorParsingModel({this.code, this.message, this.action});

  ErrorParsingModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['action'] = action;
    return data;
  }
}
