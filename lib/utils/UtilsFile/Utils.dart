import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class Utils {
  static FilteringTextInputFormatter numberFormatter =
      FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  static FilteringTextInputFormatter textFormatter =
      FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  static FilteringTextInputFormatter emailRules =
      FilteringTextInputFormatter.allow(RegExp(r'[+~/>*<!#$%^&()=?/;:,€]'));

  // static Widget getUploadImageWidget(BuildContext context,
  //     {String title = "",
  //       String desc1 = "",
  //       String desc2 = "",
  //       String icon = "needtochange/ic_attachment.svg",
  //       bool inWhite = false,
  //       bool isAddressProof = false,
  //       EdgeInsets? margin,
  //       Color? color,
  //       Function? onTap}) {
  //   return InkWell(
  //     onTap:(){
  //       onTap!();
  //     },
  //     child: new Container(
  //       margin: margin,
  //       child: new Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.max,
  //         textBaseline: TextBaseline.alphabetic,
  //         children: <Widget>[
  //           new ImageButton(
  //             icon: icon,
  //             width: 36.0,
  //             height: 36.0,
  //             margin: EdgeInsets.only(right: 4.0),
  //             isPNG: inWhite,
  //           ),
  //           new Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 new RichTextView(
  //                   title,
  //                   fontSize: 12.0,
  //                   maxLines: 1,
  //                   color: isAddressProof
  //                       ? Colors.black
  //                       : inWhite
  //                       ? Colors.white
  //                       : color ?? AppColors.lightRed,
  //                   textAlign: TextAlign.left,
  //                   //fontFamily: GOTHAMFONT.BOOK.toString(),
  //                 ),
  //                 new Row(children: <Widget>[
  //                   (desc1 == null || desc1.length == 0)
  //                       ? new Container()
  //                       : new RichTextView(
  //                     desc1,
  //                     fontSize: 12.0,
  //                     maxLines: 1,
  //                     color: isAddressProof
  //                         ? Colors.black
  //                         : inWhite
  //                         ? Colors.white
  //                         : color ?? AppColors.lightRed,
  //                     textAlign: TextAlign.left,
  //               //      fontFamily: GOTHAMFONT.BOOK.toString(),
  //                   ),
  //                   (desc2 == null || desc2.length == 0)
  //                       ? new Container()
  //                       : new RichTextView(
  //                     "(${AppTranslations.of(context).getStringByKey(desc2)})",
  //                     fontSize: 8.0,
  //                     color: isAddressProof
  //                         ? Colors.black
  //                         : inWhite
  //                         ? Colors.white
  //                         : color ?? AppColors.lightRed,
  //                     textAlign: TextAlign.left,
  //                   //  fontFamily: GOTHAMFONT.BOOK.toString(),
  //                   ),
  //                 ])
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  static int timeDuration = 300;
  static Duration duration300 = Duration(milliseconds: timeDuration);

  static bool isValidateEmail(String value) {
    // Pattern pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regex = new RegExp(pattern);

    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(value);
  }

  static String getVancouverTime() {
    var now = DateTime.now().toUtc();
    var vancouverTime = now.add(const Duration(hours: -7));
    var formatter = DateFormat('hh:mm a');
    var vancouverFormattedTime = formatter.format(vancouverTime);
    return vancouverFormattedTime;
  }

  static String getCalgaryTime() {
    var now = DateTime.now().toUtc();
    var calgaryTime = now.add(const Duration(hours: -6));
    var formatter = DateFormat('hh:mm a');
    var calgaryFormattedTime = formatter.format(calgaryTime);
    return calgaryFormattedTime;
  }

  static String getTorontoTime() {
    var now = DateTime.now().toUtc();
    var torontoTime = now.add(const Duration(hours: -4));
    var formatter = DateFormat('hh:mm a');
    var torontoFormattedTime = formatter.format(torontoTime);
    return torontoFormattedTime;
  }


  static DateTime getCompareDateFormat(inputFormat, dateString) {
    DateTime date = new DateFormat(inputFormat).parse(dateString);
    return date;
  }


// static getOSName() async{
//   DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   if(Platform.isAndroid){
//      AndroidDeviceInfo androidDeviceInfo;
//      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
//      if (kDebugMode) {
//        print("Os Name>>>>>> ${androidDeviceInfo.model}");
//      }
//      return androidDeviceInfo.model;
//   }else if(Platform.isIOS){
//     IosDeviceInfo iosDeviceInfo;
//     iosDeviceInfo = await deviceInfoPlugin.iosInfo;
//     if (kDebugMode) {
//       print("Map of IOS >>>>> ${iosDeviceInfo.utsname.machine}");
//     }
//     return iosDeviceInfo.utsname.machine;
//   }else{
//     WebBrowserInfo webBrowserInfo;
//     webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
//     if (kDebugMode) {
//       print("Map of IOS >>>>> ${webBrowserInfo.toMap()}");
//     }
//     return webBrowserInfo.browserName;
//   }
// }
//
// static getAppVersion() async{
//   final info = await PackageInfo.fromPlatform();
//   return info.version;
// }

  static String readTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var format = DateFormat("MM/dd/yyyy hh:mm a");
    return format.format(date);
  }

  static String getSocialReadableDateTime(String dateTime) {
    DateTime now = DateTime.now();
    Duration timezoneOffset = now.timeZoneOffset;
    Fimber.i('offset is == $timezoneOffset');
    DateTime convertedDateTime = getDateTimeFromServerTime(dateTime);
    convertedDateTime = convertedDateTime.add(timezoneOffset);
    return DateFormat('dd MMM yyyy  hh:mm a').format(convertedDateTime);
  }

  static DateTime getDateTimeFromServerTime(String dateTime) {
    Fimber.i('DateTime sub string before====>$dateTime');

    String dateTime1 = dateTime.substring(4, dateTime.length);
//    Fri Jul 17 2020 10:17:26
//    DDD MMM dd yyyy hh:mm:ss
    Fimber.i('DateTime sub string after====>$dateTime1');
    return  DateFormat("MMM dd yyyy hh:mm:ss").parse(dateTime1);
//
  }
  static getUTCTime(int dateTime) {
    Fimber.i('DateTime sub string====>$dateTime');
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(dateTime * 1000);
    Fimber.i('DateTime from milliseconds====>$date');
    Duration timezoneOffset = now.timeZoneOffset;
    Fimber.i('offset is == $timezoneOffset');
    DateTime convertedDateTime = DateFormat('h').parse(date.toString());
    convertedDateTime = convertedDateTime.add(timezoneOffset);
    Fimber.i('convertedDateTime == $convertedDateTime');
    String convertDate = convertedDateTime.toString();
    convertDate = convertDate.substring(11, 16);
    Fimber.i(' hours === $convertDate');
    return DateFormat.jm().format(DateFormat('H').parse(convertDate));
  }

  static String getMonthDate(int timestamp) {
    DateTime date =  DateTime.fromMillisecondsSinceEpoch(timestamp);
    return  DateFormat("MMMM d").format(date);
  }

  static String getYearMonthDate(int timestamp) {
    DateTime date =  DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static String getDateMonth(int timestamp) {
    var date =  DateTime.fromMillisecondsSinceEpoch(timestamp);
    var format =  DateFormat("d MMMM yyyy");
    return format.format(date);
  }

  static String getYear(int timestamp) {
    var date =  DateTime.fromMillisecondsSinceEpoch(timestamp);
    var format =  DateFormat("yyyy");
    return format.format(date);
  }

  static String getFormatDateTimeFromStringFormat(String dateTime) {
    DateTime newDateTime =
         DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
    return readTimestamp(newDateTime.millisecondsSinceEpoch);
  }

  static String getFormatDateFromStringFormat(String dateTime) {
    DateTime newDateTime =  DateFormat("yyyy-MM-dd").parse(dateTime);
    return readTimestamp(newDateTime.millisecondsSinceEpoch).substring(0, 10);
  }
  

  static String getMonthDateString(String dateTime) {
    DateTime newDateTime =
         DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
    return getMonthDate(newDateTime.millisecondsSinceEpoch);
  }

  static String getDateMonthString(String dateTime) {
    DateTime newDateTime =  DateFormat("yyyy-MM-dd").parse(dateTime);
    return getDateMonth(newDateTime.millisecondsSinceEpoch);
  }

  static String getYearString(String dateTime) {
    DateTime newDateTime =
         DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
    return getYear(newDateTime.millisecondsSinceEpoch);
  }

  static String getDateinMonthFormat(String dateTime) {
    DateTime newDateTime =  DateFormat("yyyy-MM-dd ").parse(dateTime);
    return newDateTime.toString();
  }

  static String dateDiff(String date) {
    DateTime now =  DateTime.now();
    DateTime newDateTime =  DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
//    print(now.millisecondsSinceEpoch-newDateTime.millisecondsSinceEpoch);
    int dayDiff = now.difference(newDateTime).inDays;
    if (dayDiff >= 7) {
      int week = ((dayDiff) / 7).round();
      if (week >= 1) {
        return ((dayDiff) / 7).round().toString() + " " + "weeks ago";
      } else {
        return ((dayDiff) / 7).round().toString() + " " + "week ago";
      }
    } else {
      if (dayDiff <= 1) {
        if (dayDiff == 1) {
          return "$dayDiff day ago";
        } else {
          return "Today";
        }
      } else {
        return "$dayDiff days ago";
      }
    }
  }

  static String readTime(int timestamp) {
    Fimber.i(timestamp.toString());
    var timeString = '';
    timestamp = timestamp *
        1000; // Conversion in Seconds from Milliseconds as per API Response

    if (timestamp >= 1000) {
      int seconds = ((timestamp / 1000) % 60)
          .round(); // Conversion in Seconds from Milliseconds
      int minutes = ((timestamp / (1000 * 60)) % 60)
          .round(); // Conversion in Minutes from Milliseconds
      int hours = ((timestamp / (1000 * 60 * 60)) % 24)
          .round(); // Conversion in Hours from Milliseconds

      Fimber.i('Hours: ' +
          hours.toString() +
          ' Minutes: ' +
          minutes.toString() +
          ' Seconds: ' +
          seconds.toString());

      if (seconds > 0 && minutes == 0) {
        timeString = '0:' + seconds.toString() + ' min';
      } else if (seconds == 0 && minutes > 0) {
        timeString = minutes.toString() + ':0 min';
      } else if (seconds > 0 && minutes > 0) {
        timeString = minutes.toString() + ':' + seconds.toString() + ' min';
      } else if (seconds > 0 && minutes > 0 && hours > 0) {
        timeString = hours.toString() +
            ':' +
            minutes.toString() +
            ':' +
            seconds.toString() +
            ' min';
      }
    } else {
      timeString = '0:0 Min';
    }

    return timeString;
  }


  static String formatDate(DateTime date) {
    DateFormat formatter =  DateFormat('dd MMM, yyyy');
    String formatted = formatter.format(date);
    formatter = DateFormat.jm();

    formatted = formatted + " - " + formatter.format(date);

    return formatted;
  }

  static DateTime formatddmmyyyy(String date) {
    // "Thursday, 09 Mar 2023 22:00:00"
    // print("Datetime now >>>>> ${DateTime.now()}");
    // DateTime dateTime = DateFormat("EEEE, dd MMM yyyy HH:mm:ss").parse(date);
    // String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
    // DateTime finalDateTime = DateTime.parse(formattedDate);
    // DateTime finalDate = DateFormat("dd-MM-yyyy").format(finalDateTime) as DateTime;
    // // DateTime finalDateTime = DateFormat("dd MM yyyy").parse(formattedDate);
    // // print("formattedDate >>>>> $formattedDate");
    // print("finalDateTime Type >>>>> ${finalDateTime.runtimeType}");
    // print("finalDateTime >>>>> ${finalDateTime}");
    // print("finalDate >>>>> ${finalDate}");
    DateFormat dateFormat = DateFormat('EEEE, dd MMM yyyy HH:mm:ss');
    DateTime dateTime = dateFormat.parse(date);
    DateFormat newDateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
    String formattedDateString = newDateFormat.format(dateTime);
    DateTime tempDate = new DateFormat("dd-MM-yyyy HH:mm:ss").parse(formattedDateString);
    return tempDate;
  }

  static DateTime getDateTime(String date) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateTime dateTime = dateFormat.parse(date);
    return dateTime;
  }



  static String getOnlyDate(String date) {
    /// 1. provide datetime formate in format variable
    /// 2. which formate of date or time get use formatter variable
    DateFormat format = DateFormat("EEEE, dd MMM yyyy");
    DateTime convertedDate = format.parse(date);
    DateFormat formatter =  DateFormat('dd MMM. yyyy');
    String finalDate = formatter.format(convertedDate);
    return finalDate;
  }

  static String getOnlyTime(String time) {
    /// 1. provide datetime formate in format variable
    /// 2. which formate of date or time get use formatter variable
    DateFormat format = DateFormat("EEEE, dd MMM yyyy");
    DateTime convertedTime = format.parse(time);
    DateFormat formatter =  DateFormat('dd MMM. yyyy');
    formatter = DateFormat.jm();
    String finalTime = formatter.format(convertedTime);
    return finalTime;
  }



  static bool isMobileNumber(String phoneNumber, String defaultCountryCode) {
    if (phoneNumber == null) {
      return false;
    }
    if (phoneNumber.startsWith("5")) {
      phoneNumber = '0' + phoneNumber;
    }

    if (phoneNumber.startsWith("+" + defaultCountryCode) ||
        phoneNumber.startsWith(defaultCountryCode) ||
        phoneNumber.startsWith("0")) {
      List<String> arr = [
        "050",
        "052",
        "055",
        "056",
        "054",
        "058",
        "97150",
        "97152",
        "97155",
        "97156",
        "97154",
        "97158"
      ];
      String newNumber = phoneNumber.replaceFirst("+", "");
      for (String prefix in arr) {
        if (newNumber.startsWith(prefix)) {
          return true;
        }
      }
    }
    return false;
  }

  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await  Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> pingCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Fimber.i('connected');
        return true;
      }
    } on SocketException catch (_) {
      Fimber.i('not connected');
    }
    return false;
  }



  // static launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  static String removeAllHtmlTags(String htmlText) {
    if (htmlText == null) return '';
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }



  static String serverTimeFormate(DateTime dateTime) {
    return DateFormat("hh:mm a").format(dateTime);
  }



  static Future<bool> checkInternetConnectionAndShowMessage() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fimber.i(">> No Connection Available <<");
      Get.snackbar("", "Internet not available");
      return false;
    } else {
      Fimber.i(">> Connection Available <<");
      return true;
    }
  }
  // static showMessageInSnackBar(String message, bool isError) {
  //   try {
  //     Get.snackbar(
  //       "",
  //       "",
  //       isDismissible: true,
  //       maxWidth: double.infinity,
  //       padding: const EdgeInsets.all(3),
  //
  //       //  margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
  //       //margin: const EdgeInsets.all(3),
  //       backgroundColor:
  //
  //       isError ? Colors.red : Colors.green,
  //       //   isError ? AppColors.errorColor.withOpacity(.5) : AppColors.successColor,
  //       colorText: Colors.white,
  //       titleText: Text(
  //         message,
  //
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.white,
  //
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     Fimber.e(e.toString());
  //   }
  // }


}
