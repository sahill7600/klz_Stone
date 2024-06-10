import 'package:KLZStone/model/Api/ContactUsResponse.dart';
import 'package:KLZStone/utils/UtilsFile/Logger.dart';
import 'package:dio/dio.dart';
import '../DataHandler/Network/APIEndpoints.dart';
import '../model/Api/LoginResponse.dart';
import 'NetworkUtil.dart';
import 'ParsedResponse.dart';

class ApiManager {
  static final ApiManager _apiManager = ApiManager._internal();

  static ApiManager get() {
    return _apiManager;
  }

  ApiManager._internal();

  static const int NO_INTERNET = 404;

  NetworkUtil _netUtil = NetworkUtil();

  // Future<ParsedResponse<LoginResponse>> login(
  //     String mobileNumber, String password) {
  //   return FirebaseMessaging.instance.getToken().then((token) {
  //     return _netUtil.post("user/login", body: {
  //       "phone": mobileNumber,
  //       "password": password,
  //       "login_type": "1",
  //       "fcm_token": token,
  //       "device_os": (Platform.isIOS) ? "ios" : "android",
  //       "source": "mobile",
  //     }).then((response) {
  //       LoginResponse? loginResponse = response.body != null
  //           ? new LoginResponse.fromJson(response.body)
  //           : null;
  //       return new ParsedResponse(response.statusCode, loginResponse!);
  //     });
  //   });
  // }

  Future<ParsedResponse<ContactUsResponse>> contactUsUser(
      String name,
      String email,
      String message,

      ) async {
    Map<String, dynamic> data = new Map();

    data["name"] = "${name}";
    data["email"] = "${email}";
    data["message"] = "${message}";

    FormData formData = FormData.fromMap(data);

    Logger.get().log("adddepartmet>>>${data}");
    Logger.get().log("adddepartmet>>>${_apiManager}");
    Logger.get().log("Job URL>>${APIEndpoints.contactUsUrl}");
    Logger.get().log("PiechartURL ____________ ?>>>>>${APIEndpoints.contactUsUrl + "?name=$name"}");
    Logger.get().log("PiechartURL1 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "&email=$email"}");
    Logger.get().log("PiechartURL2 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "&message=$message"}");
    Logger.get().log("PiechartURL3 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "?name=$name" + "&email=$email" + "&message=$message"}");

    return _netUtil
        .dioPost(APIEndpoints.contactUsUrl + "?name=$name" + "&email=$email" +
        "&message=$message", formData, hasToken: false, isFormData: false)
        .then((response) {
      ContactUsResponse? apiResponse = response.body != null
          ? ContactUsResponse.fromJson(response.body)
          : null;
      return ParsedResponse(response.statusCode, apiResponse!);
    });
  }

  ///login


  // Future<ParsedResponse<LoginModelResponse>> contactUsUser1(
  //     String email,
  //     String password,
  //
  //
  //     ) async {
  //   Map<String, dynamic> data = new Map();
  //
  //   data["email"] = "${email}";
  //   data["password"] = "${password}";
  //
  //   FormData formData = FormData.fromMap(data);
  //
  //   Logger.get().log("adddepartmet>>>${data}");
  //   // Logger.get().log("adddepartmet>>>${_apiManager}");
  //   // Logger.get().log("Job URL>>${APIEndpoints.contactUsUrl}");
  //   // Logger.get().log("PiechartURL ____________ ?>>>>>${APIEndpoints.contactUsUrl + "?name=$name"}");
  //   // Logger.get().log("PiechartURL1 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "&email=$email"}");
  //   // Logger.get().log("PiechartURL2 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "&message=$message"}");
  //   // Logger.get().log("PiechartURL3 ____________ ?>>>>>${APIEndpoints.contactUsUrl + "?name=$name" + "&email=$email" + "&message=$message"}");
  //
  //   return _netUtil
  //       .dioPost(APIEndpoints.contactUsUrl + "?email=$email" + "&password=$password", formData, hasToken: false, isFormData: false)
  //       .then((response) {
  //     LoginModelResponse? apiResponse = response.body != null
  //         ? LoginModelResponse.fromJson(response.body)
  //         : null;
  //     return LoginModelResponse(response.statusCode, apiResponse!);
  //   });
  // }


}


