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
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/user2_model.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';

class UserListController extends GetxController {
  late TextEditingController ctrKatakunci;

  var UserData = new UserModel2();

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  late RxInt currentpage = 0.obs;
  late RxInt totalpage = 0.obs;
  late List dataUser = [].obs;

  @override
  void onInit() {
    super.onInit();

    // variable
    currentpage.value = 1;
    totalpage.value = 0;

    // controller
    ctrKatakunci = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    print("pages :: onReady()");
  }

  @override
  void onClose() {
    ctrKatakunci.dispose();
  }

  nextPage(BuildContext context) async {
    if (currentpage.value == totalpage.value) return;
    currentpage = currentpage + 1;

    await loadData(context);
  }

  prevPage(BuildContext context) async {
    if (currentpage.value == 1) return;
    currentpage = currentpage - 1;

    await loadData(context);
  }

  loadData(BuildContext context) async {
    try {
      print("run process :: loadData()");

      widgetLoader.showLoaderDialog(context, pesan: "Mohon tunggu..");

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("katakunci", ctrKatakunci.text);
      ijson.addRow("page", currentpage);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          AppConfig.APP_URL, "user/list", reqData, "", "");

      var resData = res;
      var resDataUser = resData['DataUser'];
      var resDataPaging = resData['DataPaging'];
      // print(resData);

      var arrTemp = [];
      dataUser.clear();
      for (var row in resDataUser) {
        arrTemp.add({
          'kodeuser': row['kodeuser'],
          'username': row['username'],
          'nama': row['nama'],
          'telepon': row['telepon']
        });
      }

      dataUser.addAll(arrTemp);
      totalpage = resDataPaging['totalpage'];

      widgetLoader.hideDialog(context);
    } catch (e) {
      print("ERROR loadData() :: ${e.toString()}");
    }
  }

  onClick_SaveData(BuildContext context) async {
    try {} catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.alertCustom("ERROR :: ${e.toString()}", context);
    }
  }
}
