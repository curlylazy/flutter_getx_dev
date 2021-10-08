// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flut_getx_dev/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclient.dart';

class UserAEController extends GetxController {
  late final BuildContext context;
  late TextEditingController ctrUsername,
      ctrPassword,
      ctrNama,
      ctrTelepon,
      ctrAlamat;

  var UserData = new UserModel(
          username: "", password: "", nama: "", telepon: "", alamat: "")
      .obs;

  var ih = new IHttpClient();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();

  int actMode = AppConfig.APP_SAVE_MODE_ADD;
  String actPage = "user/tambah";

  @override
  void onInit() {
    super.onInit();
    ctrUsername = TextEditingController();
    ctrPassword = TextEditingController();
    ctrNama = TextEditingController();
    ctrTelepon = TextEditingController();
    ctrAlamat = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    ctrUsername.text = "iwan";
    ctrPassword.text = "12345";
    ctrNama.text = "Styawan Saputra";
    ctrTelepon.text = "08563735581";
    ctrAlamat.text = "Jalan Campuan Asri No IV D Blok BB No 67";
  }

  @override
  void onClose() {
    ctrUsername.dispose();
    ctrPassword.dispose();
    ctrNama.dispose();
    ctrTelepon.dispose();
    ctrAlamat.dispose();
  }

  onClick_SaveData(BuildContext context) async {
    try {
      FocusScope.of(context).unfocus();
      final ProgressDialog pr = ProgressDialog(context, isDismissible: false);
      await pr.show();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRowFromObject(UserData.toJson());
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res =
          await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

      await pr.hide();

      print(res);
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
