// ignore_for_file: unused_import, unnecessary_new

import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/auth_model.dart';

// model
import 'package:flut_getx_dev/model/item_model.dart';
import 'package:flut_getx_dev/model/return_model.dart';

class AuthService extends GetxController {
  // init function
  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();

  var kodeKey = "";
  var actPage = "";
  var judulPage = "";
  var SAVE_MODE = "";

  final authData = fb.group(AuthModel().toJson());

  initializeModul() {}

  onLogin() async {
    try {
      var ret = new ReturnModel();
      ret.Number = 0;
      ret.Message = "";
      ret.Data = null;

      if (StringFunction.isNullOrEmpty(authData.control('username').value)) {
        ret.Number = 1;
        ret.Message = "[username] masih kosong.";
        return ret;
      }

      if (StringFunction.isNullOrEmpty(authData.control('password').value)) {
        ret.Number = 1;
        ret.Message = "[password] masih kosong.";
        return ret;
      }

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRowFromObject(authData.value);
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(AppConfig.APP_URL, "auth/loginadmin", reqData, "", "");
      print(res);

      var resData = res;
      bool status = resData['status'];

      if (!status) {
        ret.Number = 1;
        ret.Message = resData['pesan'];
        return ret;
      }

      ret.Message = "halo, anda berhasil login kedalam sistem";
      return ret;
    } catch (e) {
      print("ERROR SERVICE :: ${e.toString()}");
      var ret = new ReturnModel();
      ret.Number = 1;
      ret.Message = "ERROR SERVICE :: ${e.toString()}";
      return ret;
    }
  }
}
