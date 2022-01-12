import 'package:get/get.dart';

// import class function
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/sessionstore.dart';

// import service
import 'package:flut_getx_dev/service/auth_service.dart';

class SplashScreenController extends GetxController {
  DialogAlert dialogAlert = DialogAlert();
  SessionStore sessionStore = SessionStore();

  @override
  void onInit() async {
    super.onInit();

    await sessionStore.setupDB();

    Future.delayed(const Duration(seconds: 4), () {
      cekAuthLogin();
    });
  }

  cekAuthLogin() async {
    try {
      bool ceklogin = await sessionStore.cekSessionLogin();
      if (ceklogin) {
        Get.offAllNamed("/dashboard");
      } else {
        Get.offAllNamed("/auth/login");
      }
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.toastError(e.toString());
    }
  }
}
