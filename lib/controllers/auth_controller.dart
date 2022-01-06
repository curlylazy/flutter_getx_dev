import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';
import 'package:flut_getx_dev/model/return_model.dart';

// import service
import 'package:flut_getx_dev/service/auth_service.dart';

class AuthController extends GetxController {
  // two way data binding

  AuthService authService = AuthService();
  DialogAlert dialogAlert = DialogAlert();

  @override
  void onInit() {
    super.onInit();

    authService.authData.control('username').value = "iwan";
    authService.authData.control('password').value = "12345";
  }

  onClickLogin() async {
    try {
      dialogAlert.proggresDialogShow();
      ReturnModel res = await authService.onLogin();
      dialogAlert.proggresDialogHide();

      if (res.Number == 1) {
        dialogAlert.alertDialog("KESALAHAN", res.Message);
        return;
      }

      dialogAlert.toastSuccess(res.Message);
      Get.offAllNamed("/dashboard");
    } catch (e) {
      print("onClickLogin :: ${e.toString()}");
      dialogAlert.toastError(e.toString());
    }
  }

  onClickLogOut() async {
    try {
      dialogAlert.proggresDialogShow();
      ReturnModel res = await authService.onLogOut();
      dialogAlert.proggresDialogHide();

      if (res.Number == 1) {
        dialogAlert.alertDialog("KESALAHAN", res.Message);
        return;
      }
      dialogAlert.toastSuccess(res.Message);
      Get.offNamed("auth/login");
    } catch (e) {
      print("onClickLogOut :: ${e.toString()}");
      dialogAlert.toastError(e.toString());
    }
  }
}
