import 'dart:developer';
import 'package:KLZStone/Enums/ViewState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {

  ViewStateEnum _state = ViewStateEnum.idle;

  ViewStateEnum get state => _state;

 // final NavigationService _navigationService = locator<NavigationService>();

  /// Change The Value Of View State

  void setLoaderState(ViewStateEnum viewState) {
    if (state != viewState) _state = viewState;
    update();
  }

  // All navigation service declare here
  //
  // redirectToPage(String routeName, {dynamic arguments}) {
  //   _navigationService.navigateTo(routeName, arguments: arguments);
  // }
  //
  // redirectWithClearBackStack(String routeName, {dynamic arguments}) {
  //   _navigationService.popAllAndNavigateTo(routeName, arguments: arguments);
  // }
  //
  // Future<void> redirectToPageWithAwait(String routeName,
  //     {dynamic arguments}) async {
  //   await _navigationService.navigateTo(routeName, arguments: arguments);
  //   return;
  // }
  //
  // redirectWithPop(String routeName, {dynamic arguments}) {
  //   _navigationService.navigateToAndPop(routeName, arguments: arguments);
  // }
  //
  // pop() {
  //   _navigationService.pop();
  // }

  showMessageInSnackBar(String message, bool isError) {
    print("showtesting not working in base cont");
    try {
      Get.snackbar(
        "",
        "",
        isDismissible: true,
        maxWidth: double.infinity,
        backgroundColor: isError ? Colors.red : Colors.green,
        colorText: Colors.white,
        titleText: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
