// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'dart:convert';
import 'dart:io';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclient.dart';

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

  var ih = new IHttpClient();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  int actMode = AppConfig.APP_SAVE_MODE_ADD;
  String actPage = "user/tambah";

  @override
  void onInit() {
    super.onInit();

    // buat controllernya
    ctrUsername = TextEditingController();
    ctrPassword = TextEditingController();
    ctrNama = TextEditingController();
    ctrTelepon = TextEditingController();
    ctrAlamat = TextEditingController();
    ctrEmail = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    print("loaded data..");
    ctrUsername.text = "iwan";
    ctrPassword.text = "12345";
    ctrNama.text = "Styawan Saputra";
    ctrTelepon.text = "08563735581";
    ctrEmail.text = "curlylazy@gmail.com";
    ctrAlamat.text = "Jalan Campuan Asri No IV D Blok BB No 67";

    // UserData.update((_) {
    //   UserData.value.username = ctrUsername.text;
    //   UserData.value.password = ctrPassword.text;
    //   UserData.value.nama = ctrNama.text;
    //   UserData.value.telepon = ctrTelepon.text;
    //   UserData.value.alamat = ctrAlamat.text;
    //   UserData.value.email = ctrEmail.text;
    //   UserData.value.jk = 'L';
    // });

    UserData.username.value = ctrUsername.text;
    UserData.password.value = ctrPassword.text;
    UserData.nama.value = ctrNama.text;
    UserData.telepon.value = ctrTelepon.text;
    UserData.alamat.value = ctrAlamat.text;
    UserData.email.value = ctrEmail.text;
    UserData.jk.value = 'L';
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

  onClick_SaveData(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      widgetLoader.showLoaderDialog(context, pesan: "Mohon tunggu..");

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRowFromObject(UserData.toJson());
      ijson.createTable();

      var reqData = ijson.generateJson();
      print(reqData);

      var res =
          await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

      widgetLoader.hideDialog(context);

      // print(res);
      var resData = jsonDecode(res);
      bool status = resData['status'];

      if (!status) {
        dialogAlert.alertCustom(resData['pesan'], context);
        return;
      }
      dialogAlert.alertCustom(resData['pesan'], context);
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.alertCustom("ERROR :: ${e.toString()}", context);
    }
  }
}
