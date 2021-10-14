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

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  var actMode = "";
  var actPage = "";
  var judulPage = "".obs;
  var id = "";

  @override
  void onInit() async {
    print("onInit data..");

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
    print("onReady data..");
    print(Get.parameters['data']);

    dialogAlert.proggresDialogShow();
    ReturnModel res =
        await itemService.setParam(Get.parameters['data'].toString());
    judulPage.value = itemService.judulPage;
    dialogAlert.proggresDialogHide();

    if (res.Number == 1) {
      dialogAlert.snackbarError(res.Message);
      return;
    }
    initEditor();

    super.onReady();
  }

  @override
  void onClose() {
    ctrKodeItem.dispose();
    ctrNamaItem.dispose();
    ctrKategori.dispose();
    ctrKeteranganItem.dispose();
    ctrHarga.dispose();

    itemService.itemData.clearData();
  }

  initEditor() {
    ctrKodeItem.text = itemService.itemData.kodeitem.value;
    ctrNamaItem.text = itemService.itemData.namaitem.value;
    ctrKategori.text = itemService.itemData.kategori.value;
    ctrKeteranganItem.text = itemService.itemData.keteranganitem.value;
    ctrHarga.text = itemService.itemData.harga.value.toString();
  }

  readData() async {
    try {} catch (e) {
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
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }
}
