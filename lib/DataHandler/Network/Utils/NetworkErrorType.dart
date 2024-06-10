import 'package:KLZStone/Services/ApiService.dart';
import 'package:dio/dio.dart';
import 'ErrorParsingModel.dart';

late OnError networkError ;

Future<OnError> getError({
  required DioError dioError,
}) {

  switch (dioError.type) {
    case DioErrorType.connectionTimeout:
      return networkError(
        ErrorParsingModel(
        //  message: LanguageConst.networkConnectionTimeout,
          message: "Network connection timeout",
          code: dioError.response?.statusCode,
          action: {},
        ),

      );
    case DioErrorType.sendTimeout:
      return networkError(
        ErrorParsingModel(
          message: "Network send timeout",
         // message: LanguageConst.networkSendTimeout,
          code: dioError.response?.statusCode,
          action: {},
        ),

      );

    case DioErrorType.receiveTimeout:
      return networkError(
        ErrorParsingModel(
          message: "Network receive timeout",
        //  message: LanguageConst.networkReceiveTimeout,
          code: dioError.response?.statusCode,
          action: {},
        ),

      );

    case DioErrorType.badResponse:
      final response = dioError.response;
      if (response == null) {
        // This should never happen, judging by the current source code
        // for Dio.
        return networkError(
          ErrorParsingModel(
            message: "Something went wrong",
            code: dioError.response?.statusCode,
            action: {},
          ),

        );
      }else {
        return networkError(
          ErrorParsingModel(
            message: response.data.toString(),
            code: dioError.response?.statusCode,
            action: {},
          ),

        );
      }

    case DioErrorType.cancel:
      return networkError(
        ErrorParsingModel(
          message: dioError.message,
          code: dioError.response?.statusCode,
          action: {},
        ),

      );

    case DioErrorType.unknown:
      return networkError(
        ErrorParsingModel(
          message: dioError.message,
          code: dioError.response?.statusCode,
          action: {},
        ),

      );
    default:
      return networkError(
        ErrorParsingModel(
          message:"something Went Wrong",
          code: dioError.response?.statusCode,
          action: {},
        ),

      );
  }
}
