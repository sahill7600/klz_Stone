class LoginModel {
  final String? username;
  final String? email;
  final String? usertype;

  LoginModel({this.username, this.email, this.usertype});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        username: json['username'],
        email: json['email'],
        usertype: json['usertype']);
  }
}
