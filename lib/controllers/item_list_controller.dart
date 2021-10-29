// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/return_model.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';

// import service
import 'package:flut_getx_dev/service/item_list_service.dart';

class ItemListController extends GetxController {
  late TextEditingController ctrKatakunci;

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  var itemService = new ItemListService();

  late RxInt currentpage = 0.obs;
  late RxInt totalpage = 0.obs;
  late List dataItem = [].obs;

  @override
  void onInit() async {
    super.onInit();

    // variable
    currentpage.value = 1;
    totalpage.value = 0;

    // controller
    ctrKatakunci = TextEditingController();
  }

  @override
  void onReady() async {
    super.onReady();
    print("pages :: onReady()");
    itemService.initData();
    await loadData();
  }

  @override
  void onClose() {
    ctrKatakunci.dispose();
  }

  nextPage() async {
    if (itemService.currentpage.value == itemService.totalpage.value) return;
    itemService.currentpage.value = itemService.currentpage.value + 1;

    await loadData();
  }

  prevPage() async {
    if (itemService.currentpage.value == 1) return;
    itemService.currentpage.value = itemService.currentpage.value - 1;

    await loadData();
  }

  refreshPage() async {
    itemService.currentpage.value = 1;
    itemService.katakunci.value = "";
    await loadData();
  }

  loadData() async {
    try {
      dialogAlert.proggresDialogShow();
      ReturnModel res = await itemService.loadData();
      dialogAlert.proggresDialogHide();

      if (res.Number != 0) {
        dialogAlert.alertDialog("KESALAHAN", res.Message);
        return;
      }
    } catch (e) {
      dialogAlert.proggresDialogHide();
      dialogAlert.snackbarError(e.toString());
      print("ERROR loadData() :: ${e.toString()}");
    }
  }

  hapusData(index) async {
    try {
      bool result = await dialogAlert.confirmDialog("KONFIRMASI HAPUS",
          "Hapus data ${itemService.dataItem[index]['namaitem']} ?");
      print(result);
      if (result) {
        dialogAlert.proggresDialogShow();
        ReturnModel res = await itemService.hapusData(index);
        dialogAlert.proggresDialogHide();

        if (res.Number != 0) {
          dialogAlert.alertDialog("KESALAHAN", res.Message);
          return;
        }

        dialogAlert.alertDialog("BERHASIL", res.Message);
      }
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }
}
