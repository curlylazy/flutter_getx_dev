// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:progress_dialog/progress_dialog.dart';

import 'dart:convert';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/item_model.dart';
import 'package:flut_getx_dev/model/return_model.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';

// import service
import 'package:flut_getx_dev/service/item_ae_service.dart';

class ItemAEController extends GetxController {
  late final BuildContext context;
  late TextEditingController ctrKodeItem,
      ctrKategori,
      ctrNamaItem,
      ctrHarga,
      ctrKeteranganItem;

  var itemService = new ItemAEService();
  var itemData = new ItemModel();

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  var actMode = "";
  var actPage = "";
  var judulPage = "".obs;
  var id = "";

  @override
  void onInit() {
    print("loaded data..");

    // buat controllernya
    ctrKodeItem = TextEditingController();
    ctrKategori = TextEditingController();
    ctrNamaItem = TextEditingController();
    ctrHarga = TextEditingController();
    ctrKeteranganItem = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() async {
    // print(Get.parameters['mode']);
    print(Get.parameters['data']);

    // var varMode = Get.parameters['mode'];
    // if (varMode == "**edit") {
    //   actMode = AppConfig.APP_SAVE_MODE_EDIT;
    //   actPage = "item/update";
    //   id = Get.parameters['data'].toString();
    //   judulPage.value = "Item Edit";
    //   await readData();
    // } else {
    //   actMode = AppConfig.APP_SAVE_MODE_ADD;
    //   judulPage.value = "Item Tambah";
    //   actPage = "item/tambah";
    // }

    print("loaded data..");
    dialogAlert.proggresDialogShow();
    await itemService.setParam(Get.parameters['data'].toString());
    judulPage.value = itemService.judulPage;
    initEditor();
    dialogAlert.proggresDialogHide();

    super.onReady();
  }

  @override
  void onClose() {
    ctrKodeItem.dispose();
    ctrNamaItem.dispose();
    ctrKategori.dispose();
    ctrKeteranganItem.dispose();
    ctrHarga.dispose();
  }

  initEditor() {
    ctrKodeItem.text = itemService.itemData.kodeitem.value;
    ctrNamaItem.text = itemService.itemData.namaitem.value;
    ctrKategori.text = itemService.itemData.kategori.value;
    ctrKeteranganItem.text = itemService.itemData.keteranganitem.value;
    ctrHarga.text = itemService.itemData.harga.value.toString();
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

      itemData.kodeitem.value = resDataUser['kodeitem'];
      itemData.namaitem.value = resDataUser['namaitem'];
      itemData.kategori.value = resDataUser['kategori'];
      itemData.keteranganitem.value = resDataUser['keteranganitem'];
      itemData.harga.value = resDataUser['harga'];
      print(itemData.toJson());

      ctrKodeItem.text = itemData.kodeitem.value;
      ctrKategori.text = itemData.kategori.value;
      ctrNamaItem.text = itemData.namaitem.value;
      ctrHarga.text = itemData.harga.value.toString();
      ctrKeteranganItem.text = itemData.keteranganitem.value;
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }

  onClick_SaveData() async {
    try {
      dialogAlert.proggresDialogShow();
      ReturnModel res = await itemService.saveData();
      dialogAlert.proggresDialogHide();

      if (res.Number == 1) {
        dialogAlert.snackbarError(res.Message);
        return;
      }

      await dialogAlert.snackbarSuccess(res.Message);
      return;

      // dialogAlert.proggresDialogShow();

      // var ijson = new IJson();
      // ijson.newTable("DataHeader");
      // ijson.addRowFromObject(itemData.toJson());
      // ijson.createTable();

      // var reqData = ijson.generateJson();
      // print(reqData);

      // var res =
      //     await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

      // dialogAlert.proggresDialogHide();

      // print(res);
      // var resData = res;
      // bool status = resData['status'];

      // if (!status) {
      //   dialogAlert.snackbarError(resData['pesan']);
      //   return;
      // }
      // dialogAlert.snackbarSuccess(resData['pesan']);
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }
}
