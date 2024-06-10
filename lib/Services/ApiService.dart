import 'dart:convert';
import 'dart:io';
import 'package:KLZStone/DataHandler/Local/storage_helper.dart';
import 'package:KLZStone/DataHandler/Network/Utils/BaseException.dart';
import 'package:KLZStone/DataHandler/Network/Utils/ErrorCodes.dart';
import 'package:KLZStone/DataHandler/Network/Utils/ErrorParsingModel.dart';
import 'package:KLZStone/DataHandler/Network/Utils/NetworkErrorType.dart';
import 'package:KLZStone/utils/UtilsFile/PrefKeys.dart';
import 'package:KLZStone/utils/UtilsFile/TimeDurations.dart';
import 'package:KLZStone/utils/UtilsFile/Utils.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

typedef OnError = Function(ErrorParsingModel);
typedef OnSuccess = Function(Map);

class ApiService {
  static final ApiService _singleton = ApiService._internal();

  ApiService._internal();

  factory ApiService() {
    return _singleton;
  }

  static Dio dio = Dio();

  int connectionTimeOut = 20000; //5s

  static Future init() async {
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
    dio.options.connectTimeout =
         Duration(seconds: TimeDurations.connectionTimeOut);
    //response should receive between this time
    dio.options.receiveTimeout =
        const Duration(seconds: TimeDurations.receiveTimeOut);
    return;
  }

  static getAuthHeaderWithAuthToken() async {
    return {
      // dio.options.headers["token"] = await UserPreference.getValue(key: PrefKeys.authToken),
      dio.options.headers["Authorization"] =
          "Bearer ${StorageHelper.instance.getStringValue(PrefKeys.authToken)}",
      dio.options.headers["Content-Type"] = "application/json"
    };
  }

  static getAuthHeader() async {
    return {dio.options.headers["Content-Type"] = "application/json"};
  }

  static Future<bool> setHeader(bool hasToken) async {
    debugPrint('Header token required ==> $hasToken');
    if (hasToken) {
      getAuthHeaderWithAuthToken();
    } else {
      getAuthHeader();
    }
    debugPrint("Header $hasToken Token ===> ${dio.options.headers}");
    return true;
  }

  static Future<void> postRequest({
    required String url,
    Map<String, dynamic>? params,
    bool hasToken = false,
    required OnError onError,
    required OnSuccess onSuccess,
  }) async {
    debugPrint('Request Type ==> POST');
    if (!await Utils.checkInternetConnectionAndShowMessage()) {
      return;
    }
    await setHeader(hasToken);
    try {
      var response = await dio.post(url, data: params);
      debugPrintAPIData(response);
      if (isValidResponse(response)) {
        try {
          // onSuccess(json.decode(response.data));
          onSuccess(response.data);
        } on BaseException catch (exception) {
          debugPrint("Exception ${exception.code}");
          debugPrint("Exception ${exception.message}");
          onSuccess(response.data);
        }
      } else {
        debugPrint('API Error ==> ${response.statusCode}');
        onError(
          ErrorParsingModel(
            message: "something Went Wrong",
            code: response.statusCode,
            action: {},
          ),
        );
      }
    } on BaseException catch (e) {
      onError(
        ErrorParsingModel(
          message: e.message,
          code: e.code,
          action: {},
        ),
      );
    }
    return;
  }

  static Future<void> deleteRequest({
    required String url,
    Map<String, dynamic>? params,
    bool hasToken = false,
    required OnError onError,
    required OnSuccess onSuccess,
  }) async {
    debugPrint('Request Type ==> DELETE');
    if (!await Utils.checkInternetConnectionAndShowMessage()) {
      return;
    }
    await setHeader(hasToken);
    try {
      var response = await dio.delete(url, data: params);
      debugPrintAPIData(response);
      if (isValidResponse(response)) {
        try {
          onSuccess(json.decode(response.data));
        } on BaseException catch (exception) {
          debugPrintException(
            code: exception.code!,
            message: exception.message,
          );
          onSuccess(response.data);
        }
      } else {
        onError(
          ErrorParsingModel(
            message: "something Went Wrong",
            code: response.statusCode,
            action: {},
          ),
        );
      }
    } on DioError catch (dioError) {
      onError = await getError(dioError: dioError);
    } on SocketException catch (socketException) {
      debugPrintException(
        code: socketException.port!,
        message: socketException.message,
      );
      onError(
        ErrorParsingModel(
          message: "Internet not available",
          code: socketException.port!,
          action: {},
        ),
      );
      // throw SocketException(socketException.toString());
    } on FormatException catch (formatException) {
      debugPrintException(
        code: formatException.offset!,
        message: formatException.message,
      );
      onError(
        ErrorParsingModel(
          message: "something Went Wrong",
          code: formatException.offset!,
          action: {},
        ),
      );
      // throw FormatException(formatException.message);
    } on BaseException catch (e) {
      onError(
        ErrorParsingModel(
          message: e.message,
          code: e.code,
          action: {},
        ),
      );
      // rethrow;
    }
    return;
  }

  static Future<void> putRequest({
    required String url,
    Map<String, dynamic>? params,
    bool hasToken = false,
    required Function onError,
    required Function onSuccess,
  }) async {
    debugPrint('Request Type ==> PUT');
    if (!await Utils.checkInternetConnectionAndShowMessage()) {
      return;
    }
    await setHeader(hasToken);
    try {
      var response = await dio.put(url, data: params);
      debugPrintAPIData(response);
      if (isValidResponse(response)) {
        try {
          onSuccess(json.decode(response.data));
        } on BaseException catch (exception) {
          debugPrintException(
            code: exception.code!,
            message: exception.message,
          );
          onSuccess(response.data);
        }
      } else {
        debugPrint('API Error ==> ${response.statusCode}');
        onError(
          ErrorParsingModel(
            message: "something Went Wrong",
            code: response.statusCode,
            action: {},
          ),
        );
      }
    } on DioError catch (dioError) {
      onError = await getError(dioError: dioError);
    } on SocketException catch (socketException) {
      debugPrintException(
        code: socketException.port!,
        message: socketException.message,
      );
      onError(
        ErrorParsingModel(
          message:"Internet not available",
          code: socketException.port!,
          action: {},
        ),
      );
      // throw SocketException(socketException.toString());
    } on FormatException catch (formatException) {
      debugPrintException(
        code: formatException.offset!,
        message: formatException.message,
      );
      onError(
        ErrorParsingModel(
          message: "something Went Wrong",
          code: formatException.offset!,
          action: {},
        ),
      );
      // throw FormatException(formatException.message);
    } on BaseException catch (e) {
      onError(
        ErrorParsingModel(
          message: e.message,
          code: e.code,
          action: {},
        ),
      );
      // rethrow;
    }
    return;
  }

  static Future<void> getRequest({
    required String url,
    Map<String, dynamic>? params,
    bool hasToken = false,
    required Function onError,
    required Function onSuccess,
  }) async {
    debugPrint('Request Type ==> GET');
    if (!await Utils.checkInternetConnectionAndShowMessage()) {
      return;
    }
    await setHeader(hasToken);
    try {
      var response = await dio.get(
        url,
      );
      debugPrintAPIData(response);
      if (isValidResponse(response)) {
        try {
          onSuccess(response.data);
        } on BaseException catch (exception) {
          debugPrintException(
            code: exception.code!,
            message: exception.message,
          );
          onSuccess(response.data);
        }
      } else {
        debugPrint('API Error ==> ${response.statusCode}');
        onError(
          ErrorParsingModel(
            message: "something Went Wrong",
            code: response.statusCode,
            action: {},
          ),
        );
      }
    } on DioError catch (dioError) {
      onError = await getError(dioError: dioError);
    } on SocketException catch (socketException) {
      debugPrintException(
        code: socketException.port!,
        message: socketException.message,
      );
      onError(
        ErrorParsingModel(
          message: "Internet not available",
          code: socketException.port!,
          action: {},
        ),
      );
      // throw SocketException(socketException.toString());
    } on FormatException catch (formatException) {
      debugPrintException(
        code: formatException.offset!,
        message: formatException.message,
      );
      onError(
        ErrorParsingModel(
          message: "something Went Wrong",
          code: formatException.offset!,
          action: {},
        ),
      );
      // throw FormatException(formatException.message);
    } on BaseException catch (e) {
      onError(
        ErrorParsingModel(
          message: e.message,
          code: e.code,
          action: {},
        ),
      );
      // rethrow;
    }
    return;
  }

  static bool isValidResponse(Response response) {
    return response.statusCode == ErrorCodes.successStatusCode;
  }

  static Future<void> uploadMediaUser({
    required String mediaType,
    required String image,
    required String url,
    bool hasToken = false,
    required OnError onError,
    required OnSuccess onSuccess,
  }) async {
    // await setHeader(hasToken);
    //
    // try {
    //   FormData formData = await getImageUploadParam(mediaType, image);
    //   var response = await dio.post(url, data: formData);
    //
    //   if (isValidResponse(response)) {
    //     onSuccess(response.data);
    //     debugPrint("message it's get image");
    //   } else {
    //     debugPrint('API Error ==> ${response.statusCode}');
    //     onError(response.data['message'], true);
    //   }
    // } catch (e) {
    //   errorHandaling(e, onError);
    // }
    // return;
    debugPrint('Request Type ==> Multipart');
    if (!await Utils.checkInternetConnectionAndShowMessage()) {
      return;
    }
    await setHeader(hasToken);
    try {
      FormData formData = await getImageUploadParam(mediaType, image);
      var response = await dio.post(url, data: formData);
      debugPrintAPIData(response);
      if (isValidResponse(response)) {
        try {
          onSuccess(json.decode(response.data));
        } on BaseException catch (exception) {
          debugPrintException(
            code: exception.code!,
            message: exception.message,
          );
          onSuccess(response.data);
        }
      } else {
        debugPrint('API Error ==> ${response.statusCode}');
        onError(
          ErrorParsingModel(
            message: "something Went Wrong",
            code: response.statusCode,
            action: {},
          ),
        );
      }
    } on DioError catch (dioError) {
      onError = await getError(dioError: dioError);
    } on SocketException catch (socketException) {
      debugPrintException(
        code: socketException.port!,
        message: socketException.message,
      );
      onError(
        ErrorParsingModel(
          message: "Internet not available",
          code: socketException.port!,
          action: {},
        ),
      );
      // throw SocketException(socketException.toString());
    } on FormatException catch (formatException) {
      debugPrintException(
        code: formatException.offset!,
        message: formatException.message,
      );
      onError(
        ErrorParsingModel(
          message: "something Went Wrong",
          code: formatException.offset!,
          action: {},
        ),
      );
      // throw FormatException(formatException.message);
    } on BaseException catch (e) {
      onError(
        ErrorParsingModel(
          message: e.message,
          code: e.code,
          action: {},
        ),
      );
      // rethrow;
    }
    return;
  }

  static Future<FormData> getImageUploadParam(
    String mediaType,
    String imagePath,
  ) async {
    List<String> imagePathSlots = imagePath.split("/");
    FormData formData = FormData.fromMap({
      "type": mediaType,
      "file": await MultipartFile.fromFile(imagePath,
          filename: imagePathSlots[imagePathSlots.length - 1]),
    });
    return formData;
  }

  static void debugPrintAPIData(Response<dynamic> response) {
    debugPrint('Request Data ==>  ${response.requestOptions.data}');
    debugPrint('Requested Endpoint ==>  ${response.requestOptions.path}');
    debugPrint('Response Data ==>  ${response.data}');
    debugPrint('Response Status Code ==>  ${response.statusCode}');
    debugPrint('Response Status Message ==>  ${response.statusMessage}');
  }

  static void debugPrintException(
      {required String message, required int code}) {
    debugPrint('Exception Message ==> $message');
    debugPrint('Exception Code ==> $code');
  }
}
