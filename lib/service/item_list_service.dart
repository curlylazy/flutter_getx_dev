import 'dart:io';

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

class ItemListService extends GetxController {
  var ih = IHttpClientGetx();

  var currentpage = 0.obs;
  var totalpage = 0.obs;
  var katakunci = "".obs;
  var dataItem = [].obs;

  initData() {
    currentpage.value = 1;
    totalpage.value = 0;
    katakunci.value = "";
    dataItem.value = [];
  }

  loadData() async {
    try {
      var ret = ReturnModel();
      ret.Number = 0;
      ret.Message = "";

      var ijson = IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("katakunci", katakunci.value);
      ijson.addRow("page", currentpage.value);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();

      var res = await ih.sendDataAsync(AppConfig.APP_URL, "item/list", reqData, "", "");

      var resData = res;
      var resDataItem = resData['DataItem'];
      var resDataPaging = resData['DataPaging'];
      print(resData);

      if (!resData['status']) {
        ret.Number = 1;
        ret.Message = resData['pesan'];
        return ret;
      }

      dataItem.clear();
      for (var row in resDataItem) {
        var itemData = ItemListModel();
        itemData.kodeitem = StringFunction.filterString(row['kodeitem']);
        itemData.kategori = StringFunction.filterString(row['kategori']);
        itemData.namaitem = StringFunction.filterString(row['namaitem']);
        itemData.harga = StringFunction.filterString(row['harga']);
        itemData.keteranganitem = StringFunction.filterString(row['keteranganitem']);
        itemData.gambaritem = StringFunction.filterString(row['gambaritem']);
        dataItem.add(itemData.toJson());
      }

      totalpage.value = resDataPaging['totalpage'];

      return ret;
    } catch (e) {
      var ret = ReturnModel();
      ret.Number = 1;
      ret.Message = "ERROR loadData() :: ${e.toString()}";
      return ret;
    }
  }

  hapusData(index) async {
    try {
      var ret = ReturnModel();
      ret.Number = 0;
      ret.Message = "";

      var ijson = IJson();
      ijson.newTable("DataHeader");
      ijson.addRow("kode", dataItem[index]['kodeitem']);
      ijson.endRow();
      ijson.createTable();

      var reqData = ijson.generateJson();
      var res = await ih.sendDataAsync(AppConfig.APP_URL, "item/delete", reqData, "", "");

      var resData = res;
      bool status = resData['status'];

      if (!status) {
        ret.Number = 1;
        ret.Message = resData['pesan'];
        return ret;
      }

      await loadData();

      ret.Number = 0;
      ret.Message = resData['pesan'];
      return ret;
    } catch (e) {
      var ret = ReturnModel();
      ret.Number = 1;
      ret.Message = "ERROR loadData() :: ${e.toString()}";
      return ret;
    }
  }
}
