// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'dart:convert';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclient.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/user_model.dart';
import 'package:flut_getx_dev/model/user2_model.dart';
import 'package:flut_getx_dev/model/pelanggan_model.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';

class UserAEController extends GetxController {
  late final BuildContext context;
  late TextEditingController ctrUsername,
      ctrPassword,
      ctrNama,
      ctrTelepon,
      ctrEmail,
      ctrAlamat;

  // var UserData = new UserModel(
  //         username: "",
  //         password: "",
  //         nama: "",
  //         telepon: "",
  //         alamat: "",
  //         jk: "",
  //         email: '')
  //     .obs;

  var UserData = new UserModel2();

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  var actMode = 0;
  var actPage = "";
  var judulPage = "".obs;
  var id = "";

  @override
  void onInit() {
    print("loaded data..");
    print(Get.parameters['mode']);
    print(Get.parameters['data']);

    // buat controllernya
    ctrUsername = TextEditingController();
    ctrPassword = TextEditingController();
    ctrNama = TextEditingController();
    ctrTelepon = TextEditingController();
    ctrAlamat = TextEditingController();
    ctrEmail = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() async {
    print("loaded data..");
    print(Get.parameters['mode']);
    print(Get.parameters['data']);

    var varMode = Get.parameters['mode'];
    if (varMode == "**edit") {
      actMode = AppConfig.APP_SAVE_MODE_EDIT;
      actPage = "user/update";
      id = Get.parameters['data'].toString();
      judulPage.value = "User Edit";
      await readData();
    } else {
      actMode = AppConfig.APP_SAVE_MODE_ADD;
      judulPage.value = "User Tambah";
      actPage = "user/tambah";
    }

    super.onReady();

    // ctrUsername.text = "iwan";
    // ctrPassword.text = "12345";
    // ctrNama.text = "Styawan Saputra";
    // ctrTelepon.text = "08563735581";
    // ctrEmail.text = "curlylazy@gmail.com";
    // ctrAlamat.text = "Jalan Campuan Asri No IV D Blok BB No 67";

    // UserData.update((_) {
    //   UserData.value.username = ctrUsername.text;
    //   UserData.value.password = ctrPassword.text;
    //   UserData.value.nama = ctrNama.text;
    //   UserData.value.telepon = ctrTelepon.text;
    //   UserData.value.alamat = ctrAlamat.text;
    //   UserData.value.email = ctrEmail.text;
    //   UserData.value.jk = 'L';
    // });

    // UserData.username.value = ctrUsername.text;
    // UserData.password.value = ctrPassword.text;
    // UserData.nama.value = ctrNama.text;
    // UserData.telepon.value = ctrTelepon.text;
    // UserData.alamat.value = ctrAlamat.text;
    // UserData.email.value = ctrEmail.text;
    // UserData.jk.value = 'L';
  }

  @override
  void onClose() {
    ctrUsername.dispose();
    ctrPassword.dispose();
    ctrNama.dispose();
    ctrTelepon.dispose();
    ctrAlamat.dispose();
    ctrEmail.dispose();
  }

  readData() async {
    try {
      dialogAlert.proggresDialogShow();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("id", id);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          AppConfig.APP_URL, "user/read", reqData, "", "");
      print(res);

      dialogAlert.proggresDialogHide();

      var resData = res;
      var resDataUser = resData['DataUser'];
      bool status = resData['status'];
      if (!status) {
        dialogAlert.snackbarError(resData['pesan']);
        return;
      }

      // print(resData['DataUser']);
      UserData.username_old.value = resDataUser['username'];
      UserData.kodeuser.value = resDataUser['kodeuser'];
      UserData.username.value = resDataUser['username'];
      UserData.password.value = resDataUser['password_dec'];
      UserData.nama.value = resDataUser['nama'];
      UserData.telepon.value = resDataUser['telepon'];
      UserData.alamat.value = resDataUser['alamat'];
      UserData.email.value = resDataUser['email'];
      UserData.jk.value = resDataUser['jk'];
      print(UserData.toJson());

      ctrUsername.text = UserData.username.value;
      ctrPassword.text = UserData.password.value;
      ctrNama.text = UserData.nama.value;
      ctrTelepon.text = UserData.telepon.value;
      ctrEmail.text = UserData.email.value;
      ctrAlamat.text = UserData.alamat.value;
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }

  onClick_SaveData() async {
    try {
      dialogAlert.proggresDialogShow();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRowFromObject(UserData.toJson());
      ijson.createTable();

      var reqData = ijson.generateJson();
      print(reqData);

      var res =
          await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

      dialogAlert.proggresDialogHide();

      print(res);
      var resData = res;
      bool status = resData['status'];

      if (!status) {
        dialogAlert.snackbarError(resData['pesan']);
        return;
      }
      dialogAlert.snackbarSuccess(resData['pesan']);
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }
}
