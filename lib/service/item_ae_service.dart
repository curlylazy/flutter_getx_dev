// ignore_for_file: unused_import, unnecessary_new

import 'package:get/get.dart';

// import class function
import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/Stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/ihttpclientgetx.dart';

// model
import 'package:flut_getx_dev/model/item_model.dart';
import 'package:flut_getx_dev/model/return_model.dart';

class ItemAEService extends GetxController {
  // init function
  var ih = new IHttpClientGetx();
  var dialogAlert = new DialogAlert();

  var kodeKey = "";
  var actPage = "";
  var judulPage = "";
  var SAVE_MODE = "";

  var itemData = new ItemModel();

  setParam(String kode) async {
    var ret = new ReturnModel();

    kodeKey = kode;
    await initializeModul();

    print(kodeKey);
    if (StringFunction.isNullOrEmpty(kodeKey)) {
      SAVE_MODE = AppConfig.APP_SAVE_MODE_ADD;
      actPage = "item/tambah";
      judulPage = "Item Tambah";

      ret.Number = 0;
      ret.Message = "";
    } else {
      SAVE_MODE = AppConfig.APP_SAVE_MODE_EDIT;
      actPage = "item/update";
      judulPage = "Item Update";
      ret = await readData();
    }

    return ret;
  }

  initializeModul() {
    itemData.kodeitem.value = "AUTO";
    itemData.namaitem.value = "";
    itemData.harga.value = "";
    itemData.kategori.value = "";
    itemData.keteranganitem.value = "";
  }

  saveData() async {
    try {
      var ret = new ReturnModel();
      ret.Number = 0;
      ret.Message = "";
      ret.Data = null;

      print(itemData.toJson());

      if (StringFunction.isNullOrEmpty(itemData.kodeitem.value)) {
        ret.Number = 1;
        ret.Message = "[kodeitem] masih kosong.";
        return ret;
      }

      if (StringFunction.isNullOrEmpty(itemData.kodeitem.value)) {
        ret.Number = 1;
        ret.Message = "[namaitem] masih kosong.";
        return ret;
      }

      if (StringFunction.isNullOrEmpty(itemData.harga.value)) {
        ret.Number = 1;
        ret.Message = "[harga] masih kosong.";
        return ret;
      }

      if (StringFunction.isNullOrEmpty(itemData.kategori.value)) {
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

      var res = await ih.sendDataAsync(AppConfig.APP_URL, actPage, reqData, "", "");

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

      var res = await ih.sendDataAsync(AppConfig.APP_URL, "item/read", reqData, "", "");
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
      itemData.harga.value = resDataItem['harga'].toString();
      itemData.kategori.value = resDataItem['kategori'];
      itemData.keteranganitem.value = resDataItem['keteranganitem'];

      ret.Number = 0;
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
