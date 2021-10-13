// ignore_for_file: unused_import, unnecessary_new

import 'package:get/get.dart';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/item_model.dart';
import 'package:flut_getx_dev/model/return_model.dart';

class ItemAEService extends GetxController {
  // init function
  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();
  var stringFunction = new StringFunction();

  var kodeKey = "";
  var actPage = "";
  var judulPage = "";
  var SAVE_MODE = "";

  var itemData = new ItemModel();

  setParam(String kode) async {
    kodeKey = kode;
    await initializeModul();

    print(kodeKey);
    if (stringFunction.isNullOrEmpty(kodeKey)) {
      SAVE_MODE = AppConfig.APP_SAVE_MODE_ADD;
      actPage = "item/tambah";
      judulPage = "Item Tambah";
    } else {
      SAVE_MODE = AppConfig.APP_SAVE_MODE_EDIT;
      actPage = "item/update";
      judulPage = "Item Update";
      await readData();
    }
  }

  initializeModul() {
    itemData.kodeitem.value = "ITEM001";
    itemData.namaitem.value = "Tori Tori Chees Cracker";
    itemData.harga.value = 10000;
    itemData.kategori.value = "Makanan";
    itemData.keteranganitem.value = "adalah sebuah makanan yang enak";
  }

  saveData() async {
    try {
      var ret = new ReturnModel();
      ret.Number = 0;
      ret.Message = "";
      ret.Data = null;

      if (stringFunction.isNullOrEmpty(itemData.kodeitem.value)) {
        ret.Number = 1;
        ret.Message = "[kodeitem] masih kosong.";
        return ret;
      }

      if (stringFunction.isNullOrEmpty(itemData.kodeitem.value)) {
        ret.Number = 1;
        ret.Message = "[namaitem] masih kosong.";
        return ret;
      }

      if (stringFunction.isNullOrEmpty(itemData.harga.value)) {
        ret.Number = 1;
        ret.Message = "[harga] masih kosong.";
        return ret;
      }

      if (stringFunction.isNullOrEmpty(itemData.kategori.value)) {
        ret.Number = 1;
        ret.Message = "[kategori] masih kosong.";
        return ret;
      }

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRowFromObject(itemData.toJson());
      ijson.createTable();

      var reqData = ijson.generateJson();
      print(reqData);

      var res =
          await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

      var resData = res;
      bool status = resData['status'];

      if (!status) {
        ret.Number = 1;
        ret.Message = resData['pesan'];
        return ret;
      }

      ret.Number = 0;
      ret.Message = resData['pesan'];
      return ret;
    } catch (e) {
      print("ERROR SERVICE :: ${e.toString()}");
      var ret = new ReturnModel();
      ret.Number = 1;
      ret.Message = "ERROR SERVICE :: ${e.toString()}";
      return ret;
    }
  }

  readData() async {
    try {
      var ret = new ReturnModel();
      ret.Number = 0;
      ret.Message = "";
      ret.Data = null;

      var ijson = new IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("id", kodeKey);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(
          AppConfig.APP_URL, "item/read", reqData, "", "");
      print(res);

      var resData = res;
      var resDataItem = resData['DataItem'];
      bool status = resData['status'];
      if (!status) {
        ret.Number = 1;
        ret.Message = resData['pesan'];
        return ret;
      }

      itemData.kodeitem.value = resDataItem['kodeitem'];
      itemData.namaitem.value = resDataItem['namaitem'];
      itemData.harga.value = resDataItem['harga'];
      itemData.kategori.value = resDataItem['kategori'];
      itemData.keteranganitem.value = resDataItem['keteranganitem'];

      ret.Number = 0;
      return ret;
    } catch (e) {
      print("ERROR SERVICE :: ${e.toString()}");
    }
  }
}
