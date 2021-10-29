// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class ItemModel {
  var kodeitem = "".obs;
  var kategori = "".obs;
  var namaitem = "".obs;
  var harga = "".obs;
  var keteranganitem = "".obs;
  var gambaritem = "".obs;

  Map<String, dynamic> toJson() => {
        'kodeitem': kodeitem.value,
        'kategori': kategori.value,
        'namaitem': namaitem.value,
        'harga': harga.value,
        'keteranganitem': keteranganitem.value,
        'gambaritem': gambaritem.value,
      };

  clearData() {
    kodeitem.value = "";
    kategori.value = "";
    namaitem.value = "";
    harga.value = "";
    keteranganitem.value = "";
    gambaritem.value = "";
  }
}

class ItemListModel {
  var kodeitem = "";
  var kategori = "";
  var namaitem = "";
  var harga = "";
  var keteranganitem = "";
  var gambaritem = "";

  Map<String, dynamic> toJson() => {
        'kodeitem': kodeitem,
        'kategori': kategori,
        'namaitem': namaitem,
        'harga': harga,
        'keteranganitem': keteranganitem,
        'gambaritem': gambaritem,
      };

  clearData() {
    kodeitem = "";
    kategori = "";
    namaitem = "";
    harga = "";
    keteranganitem = "";
    gambaritem = "";
  }
}
