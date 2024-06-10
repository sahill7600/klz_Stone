import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:KLZStone/DataHandler/Network/APIEndpoints.dart';
import 'package:KLZStone/DataHandler/Network/Utils/ErrorCodes.dart';
import 'package:KLZStone/utils/UtilsFile/Logger.dart';
import 'package:KLZStone/utils/UtilsFile/PrefKeys.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import '../DataHandler/Local/storage_helper.dart';
import 'ApiResponse.dart';
import 'ParsedResponse.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  static final NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  static const int NO_INTERNET = 404;

  static BaseOptions options = BaseOptions(
      baseUrl: APIEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 120), // 120 seconds
      receiveTimeout: const Duration(seconds: 120) // 120 seconds
      );

  static Dio dio = Dio();

  int connectionTimeOut = 20000; //5s

  static Future init() async {
    dio = Dio(options);
    //to by forget secure connection use this piece of code
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    //to avoid redirection to the browser
    dio.options.followRedirects = false;
    //to give support to DIO till response code 500
    dio.options.validateStatus = (status) {
      return status! <= ErrorCodes.serverNotReachable;
    };
    //request should be send between below time
    dio.options.connectTimeout = const Duration(seconds: 20000);
    //response should receive between this time
    dio.options.receiveTimeout = const Duration(seconds: 200000);
    return;
  }

  static Future<bool> setHeader(bool hasToken, bool isFormData) async {
    Logger.get().log('Header token required ==> $hasToken');
    if (hasToken && isFormData) { // hasToken = true && isFormData = true
      getAuthHeaderFormDataWithAuthToken();
    } else if (!hasToken && isFormData  ){ // hasToken = false && isFormData = true
      getAuthHeaderFormData();
    }
    else if (hasToken && !isFormData){ // hasToken =true&& isfomData =false
      getAuthHeaderWithAuthToken();
    } else if (!hasToken && !isFormData) { // hasToken =false&& isfomData =false
      getAuthHeader();
    }else
      {
        getAuthHeader();
      }
    Logger.get().log("Header $hasToken Token ===> ${dio.options.headers}");
    return true;
  }

  static getAuthHeaderWithAuthToken() async {
    Logger.get().log("TOkens is >>>> ${StorageHelper.instance.getStringValue(PrefKeys.authToken)}");
    return {
      // dio.options.headers["token"] = await UserPreference.getValue(key: PrefKeys.authToken),
      dio.options.headers["Authorization"] =
          "Bearer ${StorageHelper.instance.getStringValue(PrefKeys.authToken)}",
      dio.options.headers["Content-Type"] = "application/json",
    };
  }

  static getAuthHeader() async {
    return {dio.options.headers["Content-Type"] = "application/json"};
  }

  static getAuthHeaderFormDataWithAuthToken() async {
    return {
      // dio.options.headers["token"] = await UserPreference.getValue(key: PrefKeys.authToken),
      dio.options.headers["Authorization"] =
      "Bearer ${StorageHelper.instance.getStringValue(PrefKeys.authToken)}",
      dio.options.headers["Content-Type"] = "multipart/form-data",
    };
  }

  static getAuthHeaderFormData() async {
    return {dio.options.headers["Content-Type"] = "multipart/form-data"};
  }

  Future<ParsedResponse<dynamic>> dioGet(String url,
      {bool hasToken = true,bool isFormData = true, Map<String, dynamic> params = const {}}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Logger.get().log("hasToken >>>> $hasToken");
        await setHeader(hasToken,isFormData);
        Logger.get().log("Params >>>> $params");
        var response = await dio.get(
          url,
          // data: params,
        );

        Logger.get().log("Request url: ${url}");
        Logger.get().log("Response status: ${response.statusCode}");
        Logger.get().log("Response data: ${json.encode(response.data)}");

        if (response == null) {
          return getExceptionResp(NO_INTERNET, "Network not available");
        }

        //If there was an error return null
        if (response.statusCode! < 200 || response.statusCode! >= 300) {
          Logger.get().log("SocketException1");
          return getExceptionResp(
              response.statusCode!, "some thing went wrong");
        }

        ApiResponse apiResponse = ApiResponse.fromJson(response.data);
          Logger.get().log("status>>>>>>>${apiResponse.status}");
        if (apiResponse.status == true) {
          // Logger.get().log("karuna 11: ${json.encode(response.data)}");
          return ParsedResponse(response.statusCode!, response.data);
        } else {
          String jsonString = json.encode(apiResponse.toJson());

          return ParsedResponse(response.statusCode!, json.decode(jsonString));
        }
      } on TimeoutException catch (_) {
        Logger.get().log("Time Out Exception");
        Logger.get().log("SocketException12");
        return getExceptionResp(408, "Time Out Exception");
        //}
      } on Exception catch (_) {
        Logger.get().log("SocketException123");
        return getExceptionResp(NO_INTERNET, "some thing went wrong");
      }
    } else {
      Logger.get().log("SocketException1234");
      return getExceptionResp(NO_INTERNET, "Network not available");
    }
  }

  Future<ParsedResponse<dynamic>> dioPost(String url, dynamic params,
      {bool hasToken = true,bool isFormData = true,}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Logger.get().log("dioPost 000");
        await setHeader(hasToken,isFormData);
        Logger.get().log("dioPost 111");
        Logger.get().log("Params >>>>> $params");
        FormData formData = FormData();
        if(isFormData){
          formData = params;
        }
        var response = await dio.post(url,
           // data: params,
            data: isFormData ? formData : params,
            options: Options(
              method: 'POST',
              responseType: ResponseType.json, // or ResponseType.PLAIN
            ));

        Logger.get().log("dioPost 222");
        Logger.get().log("Request url: ${url}");
        Logger.get().log("Response status: ${response.statusCode}");
        Logger.get().log("Response data: ${json.encode(response.data)}");

        if (response == null) {
          return getExceptionResp(NO_INTERNET, "Network not available");
        }

        //If there was an error return null
        if (response.statusCode! < 200 || response.statusCode! >= 300) {
          Logger.get().log("SocketException1");
          Logger.get().log("Response status code>>>>>: ${response.statusCode}");
          return getExceptionResp(
              response.statusCode!, "some thing went wrong");
        }

        ApiResponse apiResponse = ApiResponse.fromJson(response.data);

        if (apiResponse.status == true) {
          // Logger.get().log("karuna 11: ${json.encode(response.data)}");
          return ParsedResponse(response.statusCode!, response.data);
        } else {
          String jsonString = json.encode(apiResponse.toJson());
          return ParsedResponse(response.statusCode!, json.decode(jsonString));
        }
      } on TimeoutException catch (_) {
        Logger.get().log("dioPost 333");
        Logger.get().log("Time Out Exception");
        // if (!hasCheckBaseUrl) {
        //   hasCheckBaseUrl = true;
        //   return setWorkingBaseUrl().then((response) async {
        //     ParsedResponse<dynamic> response = await dioPost(url, formData);
        //     StorageHelper.instance.setValue(pref_app_base_url, BASE_URL);
        //     return response;
        //   });
        // } else {
        Logger.get().log("SocketException12");
        return getExceptionResp(408, "some thing went wrong ");
        //}
      } on Exception catch (e) {
        Logger.get().log("dioPost 4444 $e");
        Logger.get().log("SocketException123");
        return getExceptionResp(NO_INTERNET, "some thing went wrong");
      }
    } else {
      Logger.get().log("SocketException1234");
      return getExceptionResp(NO_INTERNET, "Network not available");
    }
  }

  Future<ParsedResponse<dynamic>> dioPut(String url,  formData,
      {bool hasToken = true,bool isFormData = true,}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Logger.get().log("dioPost 000");
        await setHeader(hasToken,isFormData);
        Logger.get().log("dioPost 111");
        var response = await dio.put(
          url,
          data: formData,
          // options: Options(
          //   method: 'POST',
          //   responseType: ResponseType.json, // or ResponseType.PLAIN
          // )
        );

        Logger.get().log("dioPut 222");
        Logger.get().log("Request url: ${url}");
        Logger.get().log("Response status: ${response.statusCode}");
        Logger.get().log("Response data: ${json.encode(response.data)}");

        if (response == null) {
          return getExceptionResp(NO_INTERNET, "Network not available");
        }

        //If there was an error return null
        if (response.statusCode! < 200 || response.statusCode! >= 300) {
          Logger.get().log("SocketException1");
          return getExceptionResp(
              response.statusCode!, "some thing went wrong");
        }

        ApiResponse apiResponse = ApiResponse.fromJson(response.data);

        if (apiResponse.status == true) {
          // Logger.get().log("karuna 11: ${json.encode(response.data)}");
          return ParsedResponse(response.statusCode!, response.data);
        } else {
          String jsonString = json.encode(apiResponse.toJson());
          return ParsedResponse(response.statusCode!, json.decode(jsonString));
        }
      } on TimeoutException catch (_) {
        Logger.get().log("dioPost 333");
        Logger.get().log("Time Out Exception");
        // if (!hasCheckBaseUrl) {
        //   hasCheckBaseUrl = true;
        //   return setWorkingBaseUrl().then((response) async {
        //     ParsedResponse<dynamic> response = await dioPost(url, formData);
        //     StorageHelper.instance.setValue(pref_app_base_url, BASE_URL);
        //     return response;
        //   });
        // } else {
        Logger.get().log("SocketException12");
        return getExceptionResp(408, "some thing went wrong ");
        //}
      } on Exception catch (e) {
        Logger.get().log("dioPost 4444 $e");
        Logger.get().log("SocketException123");
        return getExceptionResp(NO_INTERNET, "some thing went wrong ");
      }
    } else {
      Logger.get().log("SocketException1234");
      return getExceptionResp(NO_INTERNET, "Network not available");
    }
  }

  var httpClient = HttpClient();

  ParsedResponse<dynamic> getExceptionResp(int statusCode, String message) {
    ApiResponse apiResponse = ApiResponse(false, message);
    String jsonString = json.encode(apiResponse.toJson());
    return ParsedResponse(statusCode, json.decode(jsonString));
  }
}
