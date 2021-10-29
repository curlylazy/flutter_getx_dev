// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new
import 'package:flut_getx_dev/model/item_model.dart';
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
import 'package:flut_getx_dev/model/user2_model.dart';

// import widget
import 'package:flut_getx_dev/widgets/widget_loader.dart';

class ItemListController extends GetxController {
  late TextEditingController ctrKatakunci;

  var UserData = new UserModel2();

  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();
  var widgetLoader = new WidgetLoader();

  late RxInt currentpage = 0.obs;
  late RxInt totalpage = 0.obs;
  late List dataItem = [].obs;

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
    loadData();
  }

  @override
  void onClose() {
    ctrKatakunci.dispose();
  }

  nextPage() async {
    if (currentpage.value == totalpage.value) return;
    currentpage.value = currentpage.value + 1;

    await loadData();
  }

  prevPage() async {
    if (currentpage.value == 1) return;
    currentpage.value = currentpage.value - 1;

    await loadData();
  }

  refreshPage() async {
    currentpage.value = 1;
    await loadData();
  }

  loadData() async {
    try {
      print("run process :: loadData()");

      dialogAlert.proggresDialogShow();

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("katakunci", ctrKatakunci.text);
      ijson.addRow("page", currentpage.value);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          AppConfig.APP_URL, "item/list", reqData, "", "");

      var resData = res;
      var resDataItem = resData['DataItem'];
      var resDataPaging = resData['DataPaging'];
      // print(resData);

      var arrTemp = [];
      dataItem.clear();
      for (var row in resDataItem) {
        // var dtitem = new ItemModel();
        // dtitem.
        arrTemp.add({
          'kodeitem': row['kodeitem'],
          'kategori': row['kategori'],
          'namaitem': row['namaitem'],
          'harga': row['harga'],
          'keteranganitem': row['keteranganitem'],
          'gambaritem': row['gambaritem'],
        });
      }

      dataItem.addAll(arrTemp);
      totalpage.value = resDataPaging['totalpage'];

      dialogAlert.proggresDialogHide();
    } catch (e) {
      dialogAlert.proggresDialogHide();
      dialogAlert.snackbarError(e.toString());
      print("ERROR loadData() :: ${e.toString()}");
    }
  }

  hapusData(index) async {
    try {
      bool result = await dialogAlert.confirmDialog(
          "KONFIRMASI HAPUS", "Hapus data ${dataItem[index]['namaitem']} ?");
      print(result);
      if (result) {
        var ijson = new IJson();
        ijson.newTable("DataHeader");
        ijson.addRow("kode", dataItem[index]['kodeitem']);
        ijson.endRow();
        ijson.createTable();

        dialogAlert.proggresDialogShow();

        var reqData = ijson.generateJson();
        var res = await ih.sendDataAsync(
            AppConfig.APP_URL, "item/delete", reqData, "", "");

        dialogAlert.proggresDialogHide();

        var resData = res;
        bool status = resData['status'];

        if (!status) {
          dialogAlert.snackbarError(resData['pesan']);
          return;
        }

        dialogAlert.snackbarSuccess(resData['pesan']);
        await loadData();
      }
    } catch (e) {
      print("ERROR :: ${e.toString()}");
      dialogAlert.snackbarError(e.toString());
    }
  }
}
